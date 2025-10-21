FROM texlive/texlive:latest

# 環境変数の設定
ENV DEBIAN_FRONTEND=noninteractive

# gitとsudoをインストール（ネットワーク接続が必要だが、最小限）
RUN tlmgr update --self || true

# vscodeユーザーを作成（VS Code Dev Containers用）
ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=$USER_UID

# ユーザー作成（groupaddとuseraddはすでに利用可能）
RUN groupadd --gid $USER_GID $USERNAME 2>/dev/null || true \
    && useradd --uid $USER_UID --gid $USER_GID -m -s /bin/bash $USERNAME 2>/dev/null || true \
    && mkdir -p /etc/sudoers.d \
    && echo "$USERNAME ALL=(root) NOPASSWD:ALL" > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME

# 作業ディレクトリを設定
WORKDIR /workspaces
