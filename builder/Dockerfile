FROM archlinux:latest
RUN pacman -Suy --noconfirm --needed git base-devel github-cli ccache > /dev/null
ENV USERNAME=builder
RUN useradd -m ${USERNAME}
RUN echo "${USERNAME} ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
USER ${USERNAME}
RUN mkdir /home/${USERNAME}/.config
COPY modprobed.db /home/${USERNAME}/.config/modprobed.db
COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT [ "/entrypoint.sh" ]
