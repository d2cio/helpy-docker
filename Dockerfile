FROM helpy/helpy

COPY run.sh $HELPY_HOME/run.sh
COPY database.yml $HELPY_HOME/config/database.yml
RUN chown -R $HELPY_USER:$HELPY_USER $HELPY_HOME
