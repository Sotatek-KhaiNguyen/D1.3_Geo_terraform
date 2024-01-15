import boto3
import os
import datetime


# GROUP_CLOUDWATCH_NAME = os.environ["GROUP_CLOUDWATCH_NAME"]
# DESTINATION_BUCKET = os.environ["DESTINATION_BUCKET"]
GROUP_CLOUDWATCH_NAME = "/aws/rds/instance/postgresql-db/postgresql"
DESTINATION_BUCKET = "collectlogsfordb"
PREFIX = "dev-rds-logs-achived"
NDAYS = 0
nDays = int(NDAYS)


currentTime = datetime.datetime.now()
StartDate = currentTime - datetime.timedelta(days=nDays)
EndDate = currentTime - datetime.timedelta(days=nDays - 1)


fromDate = int(StartDate.timestamp() * 1000)
toDate = int(EndDate.timestamp() * 1000)

BUCKET_PREFIX = os.path.join(PREFIX, StartDate.strftime('%Y{0}%m{0}%d').format(os.path.sep))


def lambda_handler(event, context):
    client = boto3.client('logs')
    response = client.create_export_task(
         logGroupName=GROUP_CLOUDWATCH_NAME,
         fromTime=fromDate,
         to=toDate,
         destination=DESTINATION_BUCKET,
         destinationPrefix=BUCKET_PREFIX
        )
    print(response)