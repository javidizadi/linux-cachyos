FROM archlinux:latest
RUN pacman -Suy --noconfirm --needed git base-devel github-cli ccache > /dev/null
RUN useradd -m builder
RUN echo "builder ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
USER builder
RUN mkdir /home/builder/.config
COPY modprobed.db /home/builder/.config/modprobed.db
COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT [ "/entrypoint.sh" ]
