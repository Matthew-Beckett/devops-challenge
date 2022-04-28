# Convert FaceIT Test App to Serverless/Google Cloud Functions

* Status: proposed
* Deciders: TBC <!-- optional -->
* Date: 2022/04/28 <!-- optional -->

## Context and Problem Statement

Currently, FaceIT test app is a daemonised app which is ripe for a container however it's function is incredibly simple and deploying the supporting infrastructure for containers, or Kubernetes is not ideal for this application.

## Decision Drivers <!-- optional -->

* Removes all stateful/daemonised infrastructure
* Cost optimisation, on-demand execution
* IaaC simplification, no need for Kubernetes or Container Instances
* CI simplification, Go build is ran in Google Cloud Build as part of `terraform apply`

## Considered Options

* Google Kubernetes Engine
* Google Container Instances/Cloud Run
* Google Cloud Functions Gen.1
* Google Cloud Functions Gen.2

## Decision Outcome

Chosen option: Google Cloud Functions Gen.1 was chosen due to limitaitons with the Terraform Google Cloud Beta Provider preventing rolling releases of Cloud Functions running in Cloud Run.

### Positive Consequences <!-- optional -->

* Fully managed by Google Cloud, function is invoked on incoming request, no daemonised infrastructure
* Most cost-effective than daemonised Container options
* More scalable than VM-host based container solutions such as Kubernetes

### Negative Consequences <!-- optional -->

* Results in source-code changes
  * Source code changes result in inability to local debug without additional tooling

## Pros and Cons of the Options <!-- optional -->

### Google Kubernetes Engine

This solution would look like a simple single region, multi-AZ GKE deployment balanced with application load-balancer. <!-- optional -->

* Good, re-usable for other applications
* Bad, expensive
* Bad, running when no-load
* Bad, difficult to scale-in
* Bad, slow to scale-out
* Bad, large mangement overhead/technical debt

### Google Container Instances/Cloud Run

This solution would look like a simple single region, multi-AZ Cloud Run deploymeny balanced with application load-balancer <!-- optional -->

* Bad, expensive
* Bad, running when no-load
* Good, mostly managed

### Google Cloud Functions Gen.2

This solution would be identical to the chosen solution except the version of function deployed wuld be Gen.2

* Good, improved concurrency, 
  * Gen.2 functions run managed in Cloud Run without the management overhead of interfacing with Cloud Run and  packaging Serverless functions in containters
* Bad, upstream bug in Terraform provider prevents rolling release meaning Function must be completely destroyed to update
  * This is service disrupting.
