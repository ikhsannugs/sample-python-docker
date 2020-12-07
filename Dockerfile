FROM bitnami/python:3.9-prod-debian-10
COPY . /app
WORKDIR /app
RUN pip install -r Application/requirements.txt
ENTRYPOINT ["python"]
EXPOSE 5555
CMD ["Application/runserver.py"]
