FROM freebsd/freebsd-dynamic:latest

RUN sudo pkg --install sudo

RUN useradd /bin/sh developer

USER developer
WORKDIR /home/developer

COPY --chown=developer:developer . .dotfiles/

RUN chmod +x .dotfiles/install.sh \
             .dotfiles/scripts/freebsd-installer \
             .dotfiles/scripts/arch-installer

# 7. Use the correct path for CMD
CMD ["usr/home/developer/.dotfiles/install.sh"]