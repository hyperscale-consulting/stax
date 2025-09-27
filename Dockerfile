FROM python:3.11-slim@sha256:316d89b74c4d467565864be703299878ca7a97893ed44ae45f6acba5af09d154 AS build-env
COPY . /app
WORKDIR /app

COPY . .
RUN pip install --require-hashes --no-cache-dir -r requirements.txt
RUN pip install --no-deps --no-cache-dir .


FROM gcr.io/distroless/python3-debian12:nonroot@sha256:ea332530bc348c9cb4d9aeb7cdfde2a8c7c52bff1abff0e098452ff68f0eb86e
COPY --from=build-env /usr/local/lib/python3.11/site-packages /usr/local/lib/python3.11/site-packages
COPY --from=build-env /usr/local/bin/stax /usr/local/bin/stax
ENV PYTHONPATH=/usr/local/lib/python3.11/site-packages
WORKDIR /app
ENTRYPOINT ["python", "/usr/local/bin/stax"]
