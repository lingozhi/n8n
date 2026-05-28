ARG N8N_VERSION=2.22.4
FROM docker.n8n.io/n8nio/n8n:${N8N_VERSION}

ARG N8N_I18N_CHINESE_VERSION=2.22.4
ARG N8N_I18N_CHINESE_SHA256=f143fbc3fe8b05fb8725f1427817fcc7f670b16fbef335120bb9dafe4cad6599

USER root

RUN set -eux; \
	apk add --no-cache ca-certificates curl tar; \
	archive=/tmp/editor-ui.tar.gz; \
	curl -fsSL "https://github.com/other-blowsnow/n8n-i18n-chinese/releases/download/release/${N8N_I18N_CHINESE_VERSION}/editor-ui.tar.gz" -o "$archive"; \
	echo "${N8N_I18N_CHINESE_SHA256}  $archive" | sha256sum -c -; \
	editor_dir="$(node -p "require('path').join(require('path').dirname(require.resolve('n8n-editor-ui')), 'dist')")"; \
	rm -rf "$editor_dir"; \
	mkdir -p "$editor_dir"; \
	tar -xzf "$archive" -C "$editor_dir" --strip-components=1; \
	chown -R node:node "$editor_dir"; \
	rm -f "$archive"

ENV N8N_DEFAULT_LOCALE=zh-CN

USER node
