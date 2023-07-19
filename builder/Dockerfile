FROM archlinux:latest
RUN pacman -Suy --noconfirm --needed git base-devel github-cli bc pahole cpio python
RUN useradd -m builder
USER builder
RUN mkdir /home/builder/.config
COPY modprobed.db /home/builder/.config/modprobed.db
COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT [ "/entrypoint.sh" ]
