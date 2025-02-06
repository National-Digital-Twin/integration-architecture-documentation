## How to connect to the EKS cluster via the Bastion

- **Step 1;** Setup kubeconfig
    - Run the following command on an AWS authenticated terminal. The --region and eks cluster --name are used as an example:
        - aws eks update-kubeconfig --region eu-west-2 --name ndtp-testing-ianode
- **Step 2;** Start port forwarding tunnel to the EKS cluster API server endpoint via the Bastion instance:
    - Run the following command on an AWS authenticated terminal. The target, host and ports are used as an example where;
        - **target** is the EC2 bastion instance ID
        - **host** is the EKS cluster API server endpoint, in this case, the ianode cluster
        - **portNumber** is the EKS cluster API server endpoint (https)
        - **localPortNumber** is an available port on your local machine which will used to forward over the tunnel to the EKS cluster API server endpoint
            - aws ssm start-session --region eu-west-2 --target i-050d90bf8a31bb18e --document-name AWS-StartPortForwardingSessionToRemoteHost --parameters '{"host":["7EAB60F2A000014A75E2E4F31FEB4FB2.gr7.eu-west-2.eks.amazonaws.com"],"portNumber":["443"],"localPortNumber":["9999"]}'
- **Step 3;** Update Kubeconfig to use locally opened port to EKS
    - Modify the .kube/config file (the directory is found (hidden) within your home directory), locate the EKS cluster config in this case 'ndtp-test-ianode', it should look something like this:
        - cluster: <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;certificate-authority-data: {SOME_CERT_STRING} <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;server: https://7EAB60F2A000014A75E2E4F31FEB4FB2.gr7.eu-west-2.eks.amazonaws.com <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;name: arn:aws:eks:eu-west-2:127214183387:cluster/ndtp-testing-ianode
    - Update the config to the following:
        - cluster: <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;certificate-authority-data: {SOME_CERT_STRING} <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;server: https://localhost:9999 <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;tls-server-name: 7EAB60F2A000014A75E2E4F31FEB4FB2.gr7.eu-west-2.eks.amazonaws.com <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;name: arn:aws:eks:eu-west-2:127214183387:cluster/ndtp-testing-ianode
- **Step 4:** Interact with the EKS cluster using kubectl 
    - Within a another terminal, type a kubectl command for example: 
        - kubectl version
