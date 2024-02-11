#!/usr/bin/env python3

import os
import shutil
from datetime import datetime
import argparse 


HUGO_DRAFTS_DIR = "content/posts/drafts"
HUGO_POSTS_DIR = "content/posts"

def create_new_post(title: str):
    date_prefix = datetime.now().strftime("%Y-%m-%d")
    file_name = f"{date_prefix}-{title.lower().replace(' ', '-')}.md"
    file_path = os.path.join(HUGO_DRAFTS_DIR, file_name)

    front_matter = f"""---
title: "{title}"
description: ""
author: Mansoor
date: {datetime.now().isoformat()}
lastmod: {datetime.now().isoformat()}
draft: true
url: /blog/{date_prefix}-{title.lower().replace(' ', '-')}
images: []
---

"""

    os.makedirs(os.path.dirname(file_path), exist_ok=True)
    with open(file_path, 'w') as f:
        f.write(front_matter)

    print(f"Draft post created at {file_path}")

def list_drafts():
    return [f for f in os.listdir(HUGO_DRAFTS_DIR) if f.endswith('.md')]

def publish_post(file_name: str):
    year = file_name.split('-')[0]
    new_file_name = '-'.join(file_name.split('-')[1:])
    new_path = os.path.join(HUGO_POSTS_DIR, year, new_file_name)

    os.makedirs(os.path.dirname(new_path), exist_ok=True)
    shutil.move(os.path.join(HUGO_DRAFTS_DIR, file_name), new_path)

    # Update draft status
    with open(new_path, 'r+') as f:
        content = f.read()
        content = content.replace('draft: true', 'draft: false')
        f.seek(0)
        f.write(content)
        f.truncate()

    print(f"Draft published as {new_path}")

def main():
    parser = argparse.ArgumentParser(description='Manage Hugo blog posts.')
    subparsers = parser.add_subparsers(dest='command', required=True)

    # Subparser for 'new' command
    parser_new = subparsers.add_parser('new', help='Create a new post')
    parser_new.add_argument('title', type=str, help='Title of the post')

    # Subparser for 'publish' command
    parser_publish = subparsers.add_parser('publish', help='Publish a draft post')
    parser_publish.add_argument('draft_number', type=int, nargs='?', default=0, help='Draft number to publish (optional)')

    args = parser.parse_args()

    if args.command == 'new':
        create_new_post(args.title)
    elif args.command == 'publish':
        if args.draft_number > 0:
            drafts = list_drafts()
            draft_number = args.draft_number - 1  # Adjust for zero-based index
            if 0 <= draft_number < len(drafts):
                publish_post(drafts[draft_number])
            else:
                print("Invalid draft number.")
        else:
            drafts = list_drafts()
            for i, draft in enumerate(drafts, 1):
                print(f"{i}) {draft}")
            draft_number = int(input("Select a draft to publish: ")) - 1
            if 0 <= draft_number < len(drafts):
                publish_post(drafts[draft_number])
            else:
                print("Invalid selection.")

if __name__ == "__main__":
    main()
