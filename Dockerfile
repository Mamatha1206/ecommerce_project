# backend/Dockerfile
FROM python:3.9-slim
# Set working directory inside the container
WORKDIR /app
# Copy the requirements file and install dependencies
COPY requirements.txt .
RUN pip install -r requirements.txt
# Copy the entire backend directory into the container
COPY . .
# Command to run the application
CMD ["python", "app.py"]
