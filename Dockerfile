FROM python:3.10

# Add the Dynatrace OneAgent
COPY --from=lwp00649.dev.dynatracelabs.com/linux/oneagent-codemodules:sdk / /
ENV LD_PRELOAD /opt/dynatrace/oneagent/agent/lib64/liboneagentproc.so

# Autodynatrace instrumentation
ENV AUTODYNATRACE_LOG_LEVEL DEBUG
ENV AUTODYNATRACE_FORKABLE true
ENV AUTOWRAPT_BOOTSTRAP autodynatrace

COPY main.py /
COPY requirements.txt /

RUN pip install -r requirements.txt

CMD ["gunicorn", "-k", "uvicorn.workers.UvicornWorker", "--bind=0.0.0.0:3000", "--workers=1", "main:app", "--preload"]
