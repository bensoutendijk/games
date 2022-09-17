FROM cm2network/steamcmd:root

ENV STEAMAPPID 380870
ENV STEAMAPP project-zomboid
ENV STEAMAPPDIR "/home/steam/app"

RUN mkdir -p ${STEAMAPPDIR}
RUN mkdir -p "/home/steam/Zomboid"
RUN chown -R "${USER}:${USER}" "${STEAMAPPDIR}"
RUN chown -R "${USER}:${USER}" "/home/steam/Zomboid"

# Switch to user
USER ${USER}

WORKDIR ${HOMEDIR}

CMD ["bash", "entry.sh"]

# Expose ports
EXPOSE 8766/udp \
	16261/udp \
	16262-16272/tcp