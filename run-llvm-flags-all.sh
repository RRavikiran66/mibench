#!/bin/bash
#SBATCH --job-name=llvm
#SBATCH --output=llvm-all.log

echo "Running generic-rv64"
make clean
make build_llvm FFLAG=generic-rv64
make run_llvm FFLAG=generic-rv64

echo "Running nofusion-o3-rv64"
make clean
make build_llvm FFLAG=nofusion-o3-rv64
make run_llvm FFLAG=nofusion-o3-rv64

echo "Running macroop-fusion-inorder-rv64"
make clean
make build_llvm FFLAG=macroop-fusion-inorder-rv64
make run_llvm FFLAG=macroop-fusion-inorder-rv64

echo "Running macroop-fusion-inorder-v2-rv64"
make clean
make build_llvm FFLAG=macroop-fusion-inorder-v2-rv64
make run_llvm FFLAG=macroop-fusion-inorder-v2-rv64

echo "Running macroop-fusion-o3-rv64"
make clean
make build_llvm FFLAG=macroop-fusion-o3-rv64
make run_llvm FFLAG=macroop-fusion-o3-rv64

echo "Running generic-fusion-rv64"
make clean
make build_llvm FFLAG=generic-fusion-rv64
make run_llvm FFLAG=generic-fusion-rv64

echo "Done!!"