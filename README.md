# AWS Infra
* terraform, packer, chef, ansible 등으로 aws infra를 구성한다.

# 구성
| 구분 | 내용 | 비고 |
|:--------|:--------|--------|
| ansible-repo | ansible playbook |  |
| chef-repo | chef recipes |  |
| packer-repo | packer script |  |
| terraform-repo | terraform script |  |

## 들어가면서
* AWS 상에 뭔가를 해보려면 VPC, Subnet 그리고 Bastion까지가 기본 구성이라 볼 수 있습니다.
* 여기서는 prd, devstg, mgmt용으로 3개의 VPC를 구성합니다.
  * prd: 상용 환경
  * devstg: dev 및 stage
  * mgmt: 관리
* 각 VPC는 4개의 Subnet으로 구성 됩니다.
  * 각각의 subnet은 public 1개, private 3개로 public에는 외부 접속, private은 web, was, db 영역으로 구분됩니다.
* 3개의 VPC는 mgmt를 기준으로 vpc-peering으로 구성 되어,
mgmt에 구성된 bastion에서만 devstg 및 prd bastion에 접근가능 합니다.
  * bastion은 packer를 통해 생성된 base image를 참조 해서 생성 됩니다.
* base image는 chef, ansible로 구성되며, 시간 동기화, 타임존(kor) 변경 등이 포함 됩니다.

## 구성
* ![VPC 구성도](./terraform-repo/images/vpc.png)
  * prd, devstg, mgmt는 모두 위와 같은 형태로 구성됨.
* ![VPC Peering 구성도](./terraform-repo/images/peering.png)

## 실행 절차
* docker를 통한 manager container 구성
```
docker-compose up -d
docker-compose exec aws bash
```

* Packer를 통한 Base Image 구성
```
cd 'user_folder'/packer-repo/
./build_ami.sh
```
* 협업을 위한 state 파일을 관리할 환경 구성
```
cd 'user_folder'/terraform-repo/project/backend
terraform init
terraform plan
terraform apply
```

* VPC 구성 & VPC Peering
* Packer를 통해 생성된 AMI로 bastion을 생성 합니다.
```
cd  'user_folder'/terraform-repo/project/multi-vpc
./apply.sh      # 3개의 VPC 기본 환경 / Peering / Bastion 구성
./destory.sh    # 구성 모든 resource 삭제
./bastion.sh    # mgmt bastion 접속
```
* 참고 사항
  * terraform을 통한 인프라 구성
  (https://blog.2dal.com/2017/09/17/aws-vpc-network-with-terraform/)
  * direnv를 통한 aws key 관리(https://www.44bits.io/ko/post/direnv_for_managing_directory_environment)
