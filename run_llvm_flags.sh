#!/bin/bash

echo "Running generic-rv64"
make clean
make build_automotive FFLAG=generic-rv64
cat <<EOF >/home/ssingh/mibench/jobs/generic-rv64.job
#!/bin/bash
#SBATCH --job-name=generic-rv64
#SBATCH --output=generic-rv64.log
make run_automotive FFLAG=generic-rv64
EOF
sbatch /home/ssingh/mibench/jobs/generic-rv64.job

echo "Running nofusion-o3-rv64"
make clean
make build_automotive FFLAG=nofusion-o3-rv64
cat <<EOF >/home/ssingh/mibench/jobs/nofusion-o3-rv64.job
#!/bin/bash
#SBATCH --job-name=nofusion-o3-rv64
#SBATCH --output=nofusion-o3-rv64.log
make run_automotive FFLAG=nofusion-o3-rv64
EOF
sbatch /home/ssingh/mibench/jobs/nofusion-o3-rv64.job

echo "Running macroop-fusion-inorder-rv64"
make clean
make build_automotive FFLAG=macroop-fusion-inorder-rv64
cat <<EOF >/home/ssingh/mibench/jobs/macroop-fusion-inorder-rv64.job
#!/bin/bash
#SBATCH --job-name=macroop-fusion-inorder-rv64
#SBATCH --output=macroop-fusion-inorder-rv64.log
make run_automotive FFLAG=macroop-fusion-inorder-rv64
EOF
sbatch /home/ssingh/mibench/jobs/macroop-fusion-inorder-rv64.job

echo "Running macroop-fusion-inorder-v2-rv64"
make clean
make build_automotive FFLAG=macroop-fusion-inorder-v2-rv64
cat <<EOF >/home/ssingh/mibench/jobs/macroop-fusion-inorder-v2-rv64.job
#!/bin/bash
#SBATCH --job-name=macroop-fusion-inorder-v2-rv64
#SBATCH --output=macroop-fusion-inorder-v2-rv64.log
make run_automotive FFLAG=macroop-fusion-inorder-v2-rv64
EOF
sbatch /home/ssingh/mibench/jobs/macroop-fusion-inorder-v2-rv64.job

echo "Running macroop-fusion-o3-rv64"
make clean
make build_automotive FFLAG=macroop-fusion-o3-rv64
cat <<EOF >/home/ssingh/mibench/jobs/macroop-fusion-o3-rv64.job
#!/bin/bash
#SBATCH --job-name=macroop-fusion-o3-rv64
#SBATCH --output=macroop-fusion-o3-rv64.log
make run_automotive FFLAG=macroop-fusion-o3-rv64
EOF
sbatch /home/ssingh/mibench/jobs/macroop-fusion-o3-rv64.job

echo "Running generic-fusion-rv64"
make clean
make build_automotive FFLAG=generic-fusion-rv64
cat <<EOF >/home/ssingh/mibench/jobs/generic-fusion-rv64.job
#!/bin/bash
#SBATCH --job-name=generic-fusion-rv64
#SBATCH --output=generic-fusion-rv64.log
make run_automotive FFLAG=generic-fusion-rv64
EOF
sbatch /home/ssingh/mibench/jobs/generic-fusion-rv64.job

echo "Done!!"