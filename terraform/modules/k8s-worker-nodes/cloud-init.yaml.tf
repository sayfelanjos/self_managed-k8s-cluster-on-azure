# #cloud-config
# package_update: true
# package_upgrade: true
#
# packages:
#   - curl
#   - wget
#   - git
#
# runcmd:
#   - echo "Cloud-init script executed" >> /var/log/cloud-init-custom.log
#
# write_files:
#   - path: /etc/custom-script.sh
#     content: |
#       #!/bin/bash
#       echo "Custom script from cloud-init"
#     permissions: '0755'
#
# final_message: "Cloud-init setup completed"