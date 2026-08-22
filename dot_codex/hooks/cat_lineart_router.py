import json
import re
import sys
from pathlib import Path


CAT_PATTERN = re.compile(r"猫|ネコ|ねこ|\b(?:cat|cats|kitten|kittens)\b", re.IGNORECASE)
IMAGE_PATTERN = re.compile(
    r"画像|イラスト|絵|線画|描(?:い|く|き|画)|生成|\b(?:image|illustration|draw|sketch|generate)\b",
    re.IGNORECASE,
)
SKILL_PATH = Path(__file__).parents[1] / "skills/cat-lineart-generator/SKILL.md"


def main() -> int:
    try:
        event = json.load(sys.stdin)
    except json.JSONDecodeError:
        return 0

    prompt = event.get("prompt", "")
    if not isinstance(prompt, str):
        return 0

    if not (CAT_PATTERN.search(prompt) and IMAGE_PATTERN.search(prompt)):
        return 0

    response = {
        "hookSpecificOutput": {
            "hookEventName": "UserPromptSubmit",
            "additionalContext": (
                "The user explicitly requests a cat image. Before generating, read "
                f"{SKILL_PATH} in full, then read and follow the imagegen skill it requires. "
                "Treat cat-lineart-generator as explicitly invoked for this request and follow its "
                "required generation-design approval step before calling image generation."
            ),
        }
    }
    print(json.dumps(response))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
