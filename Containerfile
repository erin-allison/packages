FROM docker.io/archlinux:base-devel

RUN pacman -Syu --needed --noconfirm git nano sudo go asciidoctor rsync

RUN echo "build ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/build && \
    useradd build

WORKDIR /root

RUN git clone https://gitlab.com/mipimipi/crema.git && \
    cd crema && \
    make && \
    make install && \
    cd /root && \
    rm -rf crema

RUN mkdir -p /home/build/.config/crema && \
    echo -e '[ea-private]\nRemotePath = "/home/build/ea-private/"\nSignDB = false' > /home/build/.config/crema/repos.conf && \
    mkdir /home/build/ea-private

WORKDIR /home/build

COPY . packages/

RUN chown -R build: /home/build

USER build

