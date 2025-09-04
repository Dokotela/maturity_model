#!/bin/bash

projectId="fhirfli-413723"
projectName="maturity-model"
localProject="maturity_model"

appDir="$localProject/"
fullVersion=$(yq eval '.version' $appDir"pubspec.yaml")
version=${fullVersion#*+}

# Setup GCP (only needed first time)
gcloud config set project $projectId
# gcloud auth login  # Uncomment if not already authenticated

#########################################
# BUILD FLUTTER WEB ASSETS
cd $localProject && flutter build web --release && cd ..

#########################################
# COPY WEB ASSETS TO SERVER
rm -rf server/web
cp -r $localProject/build/web server/web

#########################################
# BUILD AND DEPLOY DOCKER IMAGE
cd server

# Build for Cloud Run (linux/amd64)
docker build --platform linux/amd64 -t gcr.io/$projectId/$projectName:v$version .
docker push gcr.io/$projectId/$projectName:v$version

cd ..

# Deploy to Cloud Run
gcloud run deploy $projectName \
  --image gcr.io/$projectId/$projectName:v$version \
  --platform managed \
  --region us-central1 \
  --allow-unauthenticated