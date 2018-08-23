#
FROM ttp10-dckreg.ca-technologies.fr/asc/im_asc_fabo_jnk_agnt:1.0.4

ARG PATH_PROJET_RIT=/opt/Donnees/RIT-Projets

ENV PROJET_RIT=RIT901
ENV PATH_RIT_CLIENT=/opt/Logiciel/RIT-Client
ENV PATH_IBMIM=/opt/Logiciel/IBMIM
ENV PATH_IBMIMShared=/opt/Logiciel/IBMIMShared
ENV PATH_PROCPARM=/opt/Procparm
ENV PATH_IBM=/opt/var/ibm/
ENV PATH_RUN_RIT_Client=/var/run/RIT-Client
ENV PATH_LOG_RIT_Client=/var/run/RIT-Client

USER root

#Copy et unzip des zip
COPY files/IBMIM.zip /tmp/IBMIM.zip
RUN unzip /tmp/IBMIM.zip -d ${PATH_PROCPARM}/ && rm /tmp/IBMIM.zip

COPY files/${PROJET_RIT}.zip /tmp/${PROJET_RIT}.zip
RUN unzip /tmp/${PROJET_RIT}.zip -d ${PATH_PROCPARM}/ && rm /tmp/${PROJET_RIT}.zip

RUN chown cats -R ${PATH_PROCPARM} && \
    chmod u+x ${PATH_PROCPARM}/IBMIM/userinstc && \
    find ${PATH_PROCPARM} -type f -name "java" -exec chmod u+x {} \;

# Ajout de l'entrypoint
RUN mkdir -p /etc/rit /opt/jenkins-agent/rit
COPY files/entrypoint.sh /opt/jenkins-agent/rit/entrypoint.sh
RUN chown root /opt/jenkins-agent/rit/entrypoint.sh && \
    chmod +x /opt/jenkins-agent/rit/entrypoint.sh

# Ajout du template
COPY files/install-RITC.template /opt/var/install-RITC.template
COPY files/install-RITC-licence.template /opt/var/install-RITC-licence.template

#creation des repertoires
RUN mkdir -p ${PATH_RIT_CLIENT} ${PATH_IBMIM} ${PATH_IBMIMShared} ${PATH_PROJET_RIT} ${PATH_IBM} ${PATH_RUN_RIT_Client} ${PATH_LOG_RIT_Client} && \
    chown cats ${PATH_RIT_CLIENT} ${PATH_IBMIM} ${PATH_IBMIMShared} ${PATH_PROJET_RIT} ${PATH_IBM} ${PATH_RUN_RIT_Client } ${PATH_LOG_RIT_Client}
    
################### FIN creation des repertoires ####################

USER cats
ENTRYPOINT [ "/opt/jenkins-agent/rit/entrypoint.sh" ]
CMD [ "sh", "-c", "java -jar \"${AGENT_HOME}/agent.jar\" -jnlpUrl \"${JENKINS_MASTER}/computer/${AGENT_NAME}/slave-agent.jnlp\" -secret \"$AGENT_TOKEN\"" ]