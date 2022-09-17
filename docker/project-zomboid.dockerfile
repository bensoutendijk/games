FROM cm2network/steamcmd:root

ENV STEAMAPPID 380870
ENV STEAMAPP project-zomboid
ENV STEAMAPPDIR "/server"

COPY $STEAMAPP/entry.sh '/entry.sh'

RUN set -x \
    && apt-get update \
    && mkdir -p "${STEAMAPPDIR}" \
	# Add entry script
	&& { \
		echo '@ShutdownOnFailedCommand 1'; \
		echo '@NoPromptForPassword 1'; \
		echo 'force_install_dir '"${STEAMAPPDIR}"''; \
		echo 'login anonymous'; \
		echo 'app_update '"${STEAMAPPID}"''; \
		echo 'quit'; \
	   } > "${HOMEDIR}/${STEAMAPP}_update.txt" \
	&& chmod +x "/entry.sh" \
	&& chown -R "${USER}:${USER}" "/entry.sh" "${STEAMAPPDIR}" "${HOMEDIR}/${STEAMAPP}_update.txt" \
	# Clean up
	&& rm -rf /var/lib/apt/lists/*


# Switch to user
USER ${USER}

WORKDIR ${HOMEDIR}

CMD ["bash", "entry.sh"]

# Expose ports
EXPOSE 8766/udp \
	16261/udp \
	16262-16272/tcp