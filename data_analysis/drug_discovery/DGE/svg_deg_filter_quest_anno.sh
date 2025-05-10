#!/bin/bash
#SBATCH -A p31931
#SBATCH -p short
#SBATCH -t 1:00:00
#SBATCH -N 1
#SBATCH -n 1
#SBATCH --array=15-78
#SBATCH --mem=24G
#SBATCH --mail-user=lru4593@northwestern.edu
#SBATCH --mail-type=END,FAIL
#SBATCH --job-name="deg_svg_%a"
#SBATCH --output=/projects/b1131/SpatialT/10x/DGE/out_non_10x/deg_svg_%a.out

module purge all
conda activate drug_PPI
export PATH="/projects/b1131/lru4593/env/drug_PPI/bin:$PATH"
### source activate myenv

IFS=$'\n' read -d '' -r -a input_args < /projects/b1131/SpatialT/10x/DGE/non_10x.txt
IFS=$'\t' read -ra split_dirs <<< ${input_args[${SLURM_ARRAY_TASK_ID}]}
pid=${split_dirs[0]}
dsid=${split_dirs[1]}
sampleid=${split_dirs[2]}
tech=${split_dirs[3]}

echo "PID: ${pid}"
echo "DSID: ${dsid}"
echo "SampleID: ${sampleid}"
echo "Tech: ${tech}"

python /projects/b1131/SpatialT/10x/DGE/svg_deg_filter_quest_anno.py $pid $dsid $sampleid $tech
