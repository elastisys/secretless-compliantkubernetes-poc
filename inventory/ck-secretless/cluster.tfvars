cluster_name="ck-secretless"

external_net="71b10496-2617-47ae-abbc-36239f0863bb" # public-v4
floatingip_pool="public-v4"
network_name="ck-secretless"
dns_nameservers=["8.8.4.4", "8.8.8.8"]

# Elastisys Lomma and Elastisys HQ
k8s_allowed_remote_ips=["90.224.48.115/32", "194.132.164.168/32"]

image="ubuntu-20.40-server-cloudimg-amd64-20200423"

flavor_k8s_master="1493be98-d150-4f69-8154-4d59ea49681c" # b.small
flavor_k8s_node="1493be98-d150-4f69-8154-4d59ea49681c" # b.small

az_list=["se-east-1"]
az_list_node=["se-east-1"]
number_of_bastions=0
number_of_k8s_masters=1
number_of_k8s_masters_no_etcd=0
number_of_etcd=0
number_of_k8s_masters_no_floating_ip=0
number_of_k8s_masters_no_floating_ip_no_etcd=0
number_of_k8s_nodes_no_floating_ip=0
