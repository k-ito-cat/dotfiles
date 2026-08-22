#!/usr/bin/env python3
import argparse
import json
import os
from pathlib import Path
import platform
import re
import shutil
import struct
import sys
from typing import Optional
import zlib

PNG_SIGNATURE = b"\x89PNG\r\n\x1a\n"
RGBA_COLOR_TYPE = 6
EIGHT_BIT_DEPTH = 8
DOWNLOADS_FOLDER_ID = "{374DE290-123F-4565-9164-39C4925E467B}"


def fail(message: str) -> None:
    raise ValueError(message)


def parse_png(path: Path) -> tuple[int, int, int, int, Optional[bytes]]:
    data = path.read_bytes()
    if not data.startswith(PNG_SIGNATURE):
        fail("PNG signature is missing")

    offset = len(PNG_SIGNATURE)
    ihdr = None
    compressed = bytearray()
    while offset < len(data):
        if offset + 12 > len(data):
            fail("PNG chunk is truncated")
        length = struct.unpack(">I", data[offset : offset + 4])[0]
        chunk_type = data[offset + 4 : offset + 8]
        chunk_end = offset + 12 + length
        if chunk_end > len(data):
            fail("PNG chunk length is invalid")
        payload = data[offset + 8 : offset + 8 + length]
        if chunk_type == b"IHDR":
            if ihdr is not None or length != 13:
                fail("PNG IHDR is invalid")
            ihdr = struct.unpack(">IIBBBBB", payload)
        elif chunk_type == b"IDAT":
            compressed.extend(payload)
        elif chunk_type == b"IEND":
            break
        offset = chunk_end

    if ihdr is None:
        fail("PNG IHDR is missing")
    width, height, bit_depth, color_type, compression, filter_method, interlace = ihdr
    if (compression, filter_method, interlace) != (0, 0, 0):
        fail("unsupported PNG encoding")
    if not compressed:
        fail("PNG image data is missing")
    if (bit_depth, color_type) != (EIGHT_BIT_DEPTH, RGBA_COLOR_TYPE):
        return width, height, bit_depth, color_type, None

    raw = zlib.decompress(compressed)
    stride = width * 4
    expected_length = height * (stride + 1)
    if len(raw) != expected_length:
        fail("PNG scanline data is invalid")
    return width, height, bit_depth, color_type, raw


def unfilter_scanlines(width: int, height: int, raw: bytes) -> list[bytes]:
    stride = width * 4
    rows: list[bytes] = []
    offset = 0
    for _ in range(height):
        filter_type = raw[offset]
        source = raw[offset + 1 : offset + 1 + stride]
        previous = rows[-1] if rows else bytes(stride)
        row = bytearray(stride)
        for index, value in enumerate(source):
            left = row[index - 4] if index >= 4 else 0
            up = previous[index]
            upper_left = previous[index - 4] if index >= 4 else 0
            if filter_type == 0:
                result = value
            elif filter_type == 1:
                result = value + left
            elif filter_type == 2:
                result = value + up
            elif filter_type == 3:
                result = value + ((left + up) // 2)
            elif filter_type == 4:
                p = left + up - upper_left
                pa, pb, pc = abs(p - left), abs(p - up), abs(p - upper_left)
                predictor = left if pa <= pb and pa <= pc else up if pb <= pc else upper_left
                result = value + predictor
            else:
                fail(f"unsupported PNG filter type: {filter_type}")
            row[index] = result & 0xFF
        rows.append(bytes(row))
        offset += stride + 1
    return rows


def validate_transparent_edges(width: int, height: int, raw: bytes) -> None:
    rows = unfilter_scanlines(width, height, raw)
    alpha_positions = range(3, width * 4, 4)
    if any(rows[0][index] != 0 or rows[-1][index] != 0 for index in alpha_positions):
        fail("top or bottom canvas edge is not fully transparent")
    if any(row[3] != 0 or row[-1] != 0 for row in rows):
        fail("left or right canvas edge is not fully transparent")


def downloads_directory() -> Path:
    if platform.system() != "Windows":
        return Path.home() / "Downloads"
    try:
        import winreg

        with winreg.OpenKey(
            winreg.HKEY_CURRENT_USER,
            r"Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders",
        ) as key:
            location, _ = winreg.QueryValueEx(key, DOWNLOADS_FOLDER_ID)
        return Path(os.path.expandvars(location))
    except OSError as error:
        fail(f"could not resolve the Windows Downloads directory: {error}")


def destination_path(directory: Path, name: str) -> Path:
    if not re.fullmatch(r"[a-z0-9]+(?:-[a-z0-9]+)*", name):
        fail("--name must be descriptive kebab-case")
    candidate = directory / f"{name}.png"
    suffix = 2
    while candidate.exists():
        candidate = directory / f"{name}-{suffix}.png"
        suffix += 1
    return candidate


def main() -> int:
    parser = argparse.ArgumentParser(description="Validate and copy a generated transparent cat PNG to Downloads.")
    parser.add_argument("source", type=Path)
    parser.add_argument("--name")
    parser.add_argument("--check", action="store_true")
    args = parser.parse_args()
    if not args.check and not args.name:
        parser.error("--name is required unless --check is used")

    source = args.source.expanduser().resolve()
    if not source.is_file():
        fail(f"source file does not exist: {source}")
    width, height, bit_depth, color_type, raw = parse_png(source)
    if args.check:
        transparent_edges = False
        if raw is not None:
            try:
                validate_transparent_edges(width, height, raw)
            except ValueError:
                pass
            else:
                transparent_edges = True
        print(
            json.dumps(
                {
                    "width": width,
                    "height": height,
                    "is_8_bit_rgba": raw is not None,
                    "transparent_edges": transparent_edges,
                    "needs_transparency_edit": not transparent_edges,
                },
                ensure_ascii=False,
            )
        )
        return 0
    if raw is None:
        fail("expected an 8-bit RGBA PNG")
    validate_transparent_edges(width, height, raw)

    downloads = downloads_directory()
    if not downloads.is_dir():
        fail(f"Downloads directory does not exist: {downloads}")
    destination = destination_path(downloads, args.name)
    shutil.copy2(source, destination)
    print(json.dumps({"saved_to": str(destination), "width": width, "height": height}, ensure_ascii=False))
    return 0


if __name__ == "__main__":
    try:
        raise SystemExit(main())
    except (OSError, ValueError, zlib.error) as error:
        print(f"error: {error}", file=sys.stderr)
        raise SystemExit(1)
