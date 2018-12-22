#!/bin/sh

if [ -z "$TRAVIS_PULL_REQUEST" ] || [ "$TRAVIS_PULL_REQUEST" == "false" ]
then

  if [[ "$TRAVIS_BRANCH" == "staging" ]]; then
    export DOCKER_ENV=stage
    export REACT_APP_USERS_SERVICE_URL="http://testdriven-staging-alb-1185113719.us-east-1.elb.amazonaws.com"
    echo $REACT_APP_USERS_SERVICE_URL
    echo "hello"
  elif [[ "$TRAVIS_BRANCH" == "production" ]]; then
    export DOCKER_ENV=prod
  fi

  if [ "$TRAVIS_BRANCH" == "staging" ] || [ "$TRAVIS_BRANCH" == "production" ]
  then
    # curl "https://s3.amazonaws.com/aws-cli/awscli-bundle.zip" -o "awscli-bundle.zip"
    # unzip awscli-bundle.zip
    # ./awscli-bundle/install -b ~/bin/aws
    # export PATH=~/bin:$PATH
    # # add AWS_ACCOUNT_ID, AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KEY env vars
    # eval $(aws ecr get-login --region us-east-1 --no-include-email)
    export TAG=$TRAVIS_BRANCH
    echo $TAG
    export REPO=$AWS_ACCOUNT_ID.dkr.ecr.us-east-1.amazonaws.com
  fi

  if [ "$TRAVIS_BRANCH" == "staging" ]
  then
    docker-compose -f docker-compose-stage.yml push
  fi

  if [ "$TRAVIS_BRANCH" == "staging" ] || [ "$TRAVIS_BRANCH" == "production" ]
  then
    # users
    docker pull $REPO/$USERS:$TAG
    docker build $USERS_REPO -t $USERS:$COMMIT -f Dockerfile-prod --cache-from $REPO/$USERS:$TAG
    docker tag $USERS:$COMMIT $REPO/$USERS:$TAG
    docker push $REPO/$USERS:$TAG
    # users db
    docker pull $REPO/$USERS_DB:$TAG
    docker build $USERS_DB_REPO -t $USERS_DB:$COMMIT -f Dockerfile --cache-from $REPO/$USERS_DB:$TAG
    docker tag $USERS_DB:$COMMIT $REPO/$USERS_DB:$TAG
    docker push $REPO/$USERS_DB:$TAG
    # client
    docker pull $REPO/$CLIENT:$TAG
    docker build $CLIENT_REPO -t $CLIENT:$COMMIT -f Dockerfile-prod --build-arg REACT_APP_USERS_SERVICE_URL=$REACT_APP_USERS_SERVICE_URL --cache-from $REPO/$CLIENT:$TAG
    docker tag $CLIENT:$COMMIT $REPO/$CLIENT:$TAG
    docker push $REPO/$CLIENT:$TAG
    # swagger
    docker pull $REPO/$SWAGGER:$TAG
    docker build $SWAGGER_REPO -t $SWAGGER:$COMMIT -f Dockerfile-prod --cache-from $REPO/$SWAGGER:$TAG
    docker tag $SWAGGER:$COMMIT $REPO/$SWAGGER:$TAG
    docker push $REPO/$SWAGGER:$TAG
  fi
fi
