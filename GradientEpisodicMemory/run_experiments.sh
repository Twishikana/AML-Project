#!/bin/bash

MY_PYTHON="python"
MNIST_ROTA="--n_layers 4 --n_hiddens 100 --data_path data/ --save_path results/ --n_epochs 1 --batch_size 10 --log_every 100 --samples_per_task 1500 --data_file mnist_rotations.pt    --cuda no  --seed 0"


# build datasets
cd data/
cd raw/

$MY_PYTHON raw.py

cd ..

$MY_PYTHON mnist_rotations.py \
	--o mnist_rotations.pt\
	--seed 0 \
	--min_rot 0 \
	--max_rot 180 \
	--n_tasks 20

cd ..
# model "single"
#$MY_PYTHON main.py $MNIST_ROTA --model single --lr 0.003

# model "independent"
#$MY_PYTHON main.py $MNIST_ROTA --model independent --lr 0.1  --finetune yes 

# model "multimodal"
#$MY_PYTHON main.py $MNIST_ROTA  --model multimodal --lr 0.1
#$MY_PYTHON main.py $MNIST_ROTA  --model multimodal --lr 0.05

# model "GEM"
#$MY_PYTHON main.py $MNIST_ROTA --model gem --lr 0.1 --n_memories 256 --memory_strength 0.5
#$MY_PYTHON main.py $MNIST_ROTA --model gem --lr 0.1 --n_memories 512 --memory_strength 1
$MY_PYTHON main.py $MNIST_ROTA --model gem --lr 0.1 --n_memories 512 --memory_strength 2

# plot results
#cd results/
#$MY_PYTHON plot_results.py
#cd ..
