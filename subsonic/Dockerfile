FROM alpine

ARG SUBSONIC_VERSION
ENV SUBSONIC_VERSION ${SUBSONIC_VERSION}

# Desired UID & GID
ARG SUBSONIC_UID
ARG SUBSONIC_GID

# This is where subsonic will write its state. Should be mapped to a docker
# volume or a location outside the container. The unfortunate name comes from
# the upstream subsonic.sh, which uses SUBSONIC_HOME for a data directory.
ARG SUBSONIC_BIN
ENV SUBSONIC_BIN ${SUBSONIC_BIN}

ARG SUBSONIC_HOME
ENV SUBSONIC_HOME ${SUBSONIC_HOME}

# Internal home directory for the "subsonic" user (internal to the container).
# and main location for subsonic binaries.
ARG SUBSONIC_MUSIC_DIR
ENV SUBSONIC_DEFAULT_MUSIC_FOLDER ${SUBSONIC_MUSIC_DIR}

# Add subsonic tar.gz
ADD https://sourceforge.net/projects/subsonic/files/subsonic/${SUBSONIC_VERSION}/subsonic-${SUBSONIC_VERSION}-standalone.tar.gz/download /tmp/subsonic.tar.gz

# - Create a new group 'subsonic' with SUBSONIC_GID, home $SUBSONIC_BIN
RUN echo "subsonic:x:$SUBSONIC_UID:$SUBSONIC_GID:Subsonic User:$SUBSONIC_BIN:/bin/sh" >> /etc/passwd
RUN echo "subsonic:x:$SUBSONIC_GID:Subsonic Group" >> /etc/group

# - Create the $SUBSONIC_BIN
# - Create user 'subsonic' with SUBSONIC_UID, add to that group.
# - Set permissions of $SUBSONIC_BIN
RUN mkdir -p $SUBSONIC_BIN && \
    chown subsonic $SUBSONIC_BIN && \
    chmod 0770 $SUBSONIC_BIN

# Extract subsonic bin & clean
RUN tar zxvf /tmp/subsonic.tar.gz -C $SUBSONIC_BIN && \
    rm -f /tmp/*.tar.gz

# Create subsonic data directory ($SUBSONIC_HOME). This is where subsonic stores
# its state information. This is normally overriden with --volume, but we create
# it here in case the user prefers to save state in the container itself.
RUN mkdir -p $SUBSONIC_HOME && \
    chown subsonic $SUBSONIC_HOME && \
    chmod 0770 $SUBSONIC_HOME

# Install java8, ffmpeg, lame & friends.
RUN apk --update add openjdk8-jre ffmpeg

# Create hardlinks to the transcoding binaries so we can mount a volume
# over $SUBSONIC_HOME. If you mount a volume over $SUBSONIC_HOME, create
# symlinks on the host.
#
# TODO: Investigate a better way to do this.
RUN mkdir -p $SUBSONIC_HOME/transcode && \
    ln /usr/bin/ffmpeg /usr/bin/lame $SUBSONIC_HOME/transcode

VOLUME $SUBSONIC_HOME

EXPOSE 4040

USER subsonic

COPY startup.sh /startup.sh

CMD []
ENTRYPOINT ["/startup.sh"]
