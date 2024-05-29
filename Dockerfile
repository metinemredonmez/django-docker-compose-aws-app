# Pull official base image
FROM python:3.12-slim

# Set environment variables
ENV PYTHONUNBUFFERED 1
ENV VIRTUAL_ENV=/opt/venv

# Update and install system dependencies
RUN apt-get update && apt-get install -y python3-dev build-essential

# Create and activate virtual environment
RUN python -m venv $VIRTUAL_ENV
ENV PATH="$VIRTUAL_ENV/bin:$PATH"

# Upgrade pip and install required packages
RUN pip install --upgrade pip
ADD ./requirements.txt /tmp/requirements.txt
RUN pip install -r /tmp/requirements.txt

# Copy project files to the working directory
COPY . /srv/app

# Set the working directory
WORKDIR /srv/app

# Expose the port the app runs on
EXPOSE 8000

# Run the application
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]


#pip install -r requirements.txt
#python3 manage.py runserver
#python3 manage.py migrate

