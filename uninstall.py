#!/usr/bin/env python

from __future__ import print_function

import argparse
import glob
import os
import sys
import yaml

CONFIGS = "meta/configs/*.yaml"


def main():
    parser = argparse.ArgumentParser(description="Uninstall dotfiles links.")
    parser.add_argument(
        "--dry-run",
        "-n",
        action="store_true",
        help="Show what would be removed without actually removing it",
    )
    args = parser.parse_args()

    files = glob.glob(CONFIGS)
    for processing_file in files:
        if args.dry_run:
            print("Processing {}...".format(processing_file))
        
        with open(processing_file, "r") as stream:
            try:
                conf = yaml.load(stream, yaml.FullLoader)
            except Exception as e:
                print("Error loading {}: {}".format(processing_file, e))
                continue

            if not conf:
                continue

            for section in conf:
                if 'link' in section:
                    for target in section['link']:
                        realpath = os.path.expanduser(target)
                        if os.path.islink(realpath):
                            if args.dry_run:
                                print("Would remove {}".format(realpath))
                            else:
                                print("Removing {}".format(realpath))
                                os.unlink(realpath)
                        elif os.path.exists(realpath):
                            if args.dry_run:
                                print("Skipping {} (not a symlink)".format(realpath)) 
                            # If not dry run, we usually don't print skips or maybe we do? 
                            # Original code didn't iterate this way, but my previous version did.
                            # I'll keep it consistent.
                            elif not args.dry_run: # Explicitly checking for clarity, though redundant if above logic holds
                                print("Skipping {} (not a symlink)".format(realpath))


if __name__ == "__main__":
    main()