# Jenkins swarm slave

A [Jenkins swarm](https://wiki.jenkins-ci.org/display/JENKINS/Swarm+Plugin) slave.

For a container with ssh enabled see

## Running

To run a Docker container passing [any parameters](https://wiki.jenkins-ci.org/display/JENKINS/Swarm+Plugin#SwarmPlugin-AvailableOptions) to the slave

    docker run joalherrero/jenkins-swarm-slave -master http://jenkins:8080 -username jenkins -password jenkins -executors 1

Linking to the Jenkins master container there is no need to use `--master`

    docker run -d --name jenkins -p 8080:8080 joalherrero/jenkins-swarm
    docker run -d --link jenkins:jenkins joalherrero/jenkins-swarm-slave -username jenkins -password jenkins -executors 1
    
    docker run --detach --name ansible-agent joalherrero/ansible-agent -username jenkins -password jenkins -executors 5 -labels "ansible-agent"    	

# Building

    docker build -t csanchez/jenkins-swarm-slave .
