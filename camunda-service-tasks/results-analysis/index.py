import matplotlib.pyplot as plt
import matplotlib.ticker as ticker
import numpy as np
import json
import os
from pprint import pprint

# get all results
results = []
result_files = os.listdir('../experiment-results')
for result_file in result_files:
  with open(f'../experiment-results/{result_file}') as f:
    run = json.load(f)
    results.append({
      "tag": run['tag'],
      "concurrent": run['concurrent'],
      "allDurationsInMillis": list(map(lambda datum: datum['durationInMillis'], run['processesData'])),
    })
    
# key by tag, then by concurrent
keyed = {}
for result in results:
  if not keyed.get(result['tag']):
    keyed[result['tag']] = {}
  keyed[result['tag']][result['concurrent']] = result

# ===== Comparing All =====
# boxplot durations
# dimensions: tag and concurrency

rows = ['1       ', '10      ', '100     ']
cols = [
  'Basic Java \nClass',
  'Basic Node \nTask Client - \n1 worker',
  'Basic Node \nTask Client - \n2 workers',
  'Advanced Java \nClass',
  'Advanced Node \nTask Client - \n1 worker',
  'Advanced Node \nTask Client - \n2 workers',
]
fig, axs = plt.subplots(len(rows), len(cols), sharex=True, sharey=True, figsize=(12, 8))

for ax, col in zip(axs[0], cols):
    ax.set_title(col)

for ax, row in zip(axs[:,0], rows):
    ax.set_ylabel(row, rotation=0, size='large')
    ax.yaxis.set_major_formatter(ticker.FuncFormatter(lambda x, pos: '{:,.0f}'.format(x/1000) + 's'))

fig.tight_layout()

## actual plots

axs[0,0].boxplot(keyed['basic-java-class']['1']['allDurationsInMillis'], showfliers=False)
axs[1,0].boxplot(keyed['basic-java-class']['10']['allDurationsInMillis'], showfliers=False)
axs[2,0].boxplot(keyed['basic-java-class']['100']['allDurationsInMillis'], showfliers=False)

axs[0,1].boxplot(keyed['basic-node-task-client-single-worker']['1']['allDurationsInMillis'], showfliers=False)
axs[1,1].boxplot(keyed['basic-node-task-client-single-worker']['10']['allDurationsInMillis'], showfliers=False)
axs[2,1].boxplot(keyed['basic-node-task-client-single-worker']['100']['allDurationsInMillis'], showfliers=False)

# axs[0,2].boxplot(keyed['basic-node-task-client-double-worker']['1']['allDurationsInMillis'], showfliers=False)
# axs[1,2].boxplot(keyed['basic-node-task-client-double-worker']['10']['allDurationsInMillis'], showfliers=False)
# axs[2,2].boxplot(keyed['basic-node-task-client-double-worker']['100']['allDurationsInMillis'], showfliers=False)

axs[0,3].boxplot(keyed['advanced-java-class']['1']['allDurationsInMillis'], showfliers=False)
axs[1,3].boxplot(keyed['advanced-java-class']['10']['allDurationsInMillis'], showfliers=False)
axs[2,3].boxplot(keyed['advanced-java-class']['100']['allDurationsInMillis'], showfliers=False)

# axs[0,4].boxplot(keyed['advanced-node-task-client-single-worker']['1']['allDurationsInMillis'], showfliers=False)
# axs[1,4].boxplot(keyed['advanced-node-task-client-single-worker']['10']['allDurationsInMillis'], showfliers=False)
# axs[2,4].boxplot(keyed['advanced-node-task-client-single-worker']['100']['allDurationsInMillis'], showfliers=False)

# axs[0,5].boxplot(keyed['advanced-node-task-client-double-worker']['1']['allDurationsInMillis'], showfliers=False)
# axs[1,5].boxplot(keyed['advanced-node-task-client-double-worker']['10']['allDurationsInMillis'], showfliers=False)
# axs[2,5].boxplot(keyed['advanced-node-task-client-double-worker']['100']['allDurationsInMillis'], showfliers=False)

plt.savefig('./all_boxplots.png')


# ===== Examine Node Task Client worker parallelism =====

# Suspicion: network latency / ping