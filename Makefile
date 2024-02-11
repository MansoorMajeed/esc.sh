# Variables
HUGO = hugo
DATE = $(shell date +%Y-%m-%dT%H:%M:%S%z)
YEAR = $(shell date +%Y)
TITLE =
FILE_NAME = $(shell echo $(TITLE) | tr '[:upper:]' '[:lower:]' | tr ' ' '-')
DRAFTS_DIR = content/posts/drafts
POSTS_DIR = content/posts/$(YEAR)

.PHONY: new serve publish

new:
	@echo "Enter post title: "; \
	read TITLE; \
	FILE_NAME=$$(echo "$$TITLE" | tr '[:upper:]' '[:lower:]' | tr -s ' ' '-' | sed "s/[^a-zA-Z0-9-]//g"); \
	FILE_PATH="$(DRAFTS_DIR)/$$FILE_NAME.md"; \
	echo -e "---\ntitle: \"$$TITLE\"\ndescription: \"\"\nauthor: Mansoor\ndate: $(DATE)\nlastmod: $(DATE)\ndraft: true\nurl: /blog/$$FILE_NAME\nimages: []\n---\n\n" > "$$FILE_PATH"; \
	echo "Draft post created at $$FILE_PATH"

serve:
	$(HUGO) server -D

publish:
	@echo "Select a draft to publish:"; \
	FILES=$$(ls $(DRAFTS_DIR)/*.md); \
	if [ -z "$$FILES" ]; then \
		echo "No drafts available."; \
		exit 1; \
	fi; \
	IFS=$$'\n'; \
	select FILENAME in $$FILES; do \
		TEST=$$FILENAME; \
		if [ -z "$$TEST" ]; then \
			echo "Invalid selection."; \
		else \
			break; \
		fi; \
	done; \
	clear; \
	FILE_BASE=$$(basename $$FILENAME .md); \
	mkdir -p $(POSTS_DIR); \
	mv $$FILENAME $(POSTS_DIR)/$$FILE_BASE.md; \
	sed -i'' -e 's/draft: true/draft: false/' $(POSTS_DIR)/$$FILE_BASE.md; \
	echo "Draft $$FILE_BASE.md published in $(POSTS_DIR)/."
