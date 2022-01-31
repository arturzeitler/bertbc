# Classify news with BERT and tensorflow serving and AWS

## TO BE CONTINUED

## Summary

This repo shows how to use transer learning on a BERT model to classify bbc news. The created model is then deployed to AWS declaratively with AWS Cloudformation and built on every main-commit using AWS Codebuild.
A flask API is used to send requests to the tensorflow serving container, and give users are readable response.
The flask api sits behind a public load balancer, while the tensorflow serving container sits behind a private load balancer.
Logs are sent to AWS Cloudwatch
Flask endopints can be tested locally with pytest.

## Colab Notebook
https://colab.research.google.com/drive/1URSlpijdpmGhWpGeaQallorAJSSWR0DI?usp=sharing

