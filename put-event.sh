#!/bin/bash



export seq=$(aws logs describe-log-streams --log-group-name my-ec2-instances | jq .logStreams[1].uploadSequenceToken | tr -d '"')
export timestamp=$(($(date +'%s * 1000 + %-N / 1000000')))

aws logs put-log-events \
  --log-group-name my-ec2-instances --log-stream-name stream1 \
  --log-events timestamp=$timestamp,message="PutStream1$1" \
  --sequence-token $seq


export seq=$(aws logs describe-log-streams --log-group-name my-ec2-instances | jq .logStreams[2].uploadSequenceToken | tr -d '"')
export timestamp=$(($(date +'%s * 1000 + %-N / 1000000')))

aws logs put-log-events \
  --log-group-name my-ec2-instances --log-stream-name stream2 \
  --log-events timestamp=$timestamp,message="PutStream2$1" \
  --sequence-token $seq
