import matplotlib.pyplot as plt
import matplotlib.ticker as ticker
import numpy as np
import json
import os
from pprint import pprint

experiment_results_folder = '../experiment-results'
experiment_results_folder = '../experiment-results-w-tomcat-limit'

# get all results
results = []
result_files = os.listdir(experiment_results_folder)
for result_file in result_files:
  with open(f'{experiment_results_folder}/{result_file}') as f:
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

# def generate_boxplot(
#   name="all_boxplots",
#   rows=['1', '10', '100'],
#   cols=[
#     'Basic Java \nClass',
#     'Basic Node \nTask Client - \n1 worker',
#     'Basic Node \nTask Client - \n2 workers',
#     'Advanced Java \nClass',
#     'Advanced Node \nTask Client - \n1 worker',
#     'Advanced Node \nTask Client - \n2 workers',
#   ],

# )

# ===== Comparing All =====
# boxplot durations
# dimensions: tag and concurrency

rows = ['1', '10', '100']
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
    ax.yaxis.set_major_formatter(ticker.FuncFormatter(lambda x, pos: '{:,.0f}'.format(x/1000/60) + 'mins'))

fig.tight_layout()

## actual plots

axs[0,0].boxplot(keyed['basic-java-class']['1']['allDurationsInMillis'], showfliers=False)
axs[1,0].boxplot(keyed['basic-java-class']['10']['allDurationsInMillis'], showfliers=False)
axs[2,0].boxplot(keyed['basic-java-class']['100']['allDurationsInMillis'], showfliers=False)

axs[0,1].boxplot(keyed['basic-node-task-client-single-worker']['1']['allDurationsInMillis'], showfliers=False)
axs[1,1].boxplot(keyed['basic-node-task-client-single-worker']['10']['allDurationsInMillis'], showfliers=False)
axs[2,1].boxplot(keyed['basic-node-task-client-single-worker']['100']['allDurationsInMillis'], showfliers=False)

axs[0,2].boxplot(keyed['basic-node-task-client-double-worker']['1']['allDurationsInMillis'], showfliers=False)
axs[1,2].boxplot(keyed['basic-node-task-client-double-worker']['10']['allDurationsInMillis'], showfliers=False)
axs[2,2].boxplot(keyed['basic-node-task-client-double-worker']['100']['allDurationsInMillis'], showfliers=False)

axs[0,3].boxplot(keyed['advanced-java-class']['1']['allDurationsInMillis'], showfliers=False)
axs[1,3].boxplot(keyed['advanced-java-class']['10']['allDurationsInMillis'], showfliers=False)
axs[2,3].boxplot(keyed['advanced-java-class']['100']['allDurationsInMillis'], showfliers=False)

axs[0,4].boxplot(keyed['advanced-node-task-client-single-worker']['1']['allDurationsInMillis'], showfliers=False)
axs[1,4].boxplot(keyed['advanced-node-task-client-single-worker']['10']['allDurationsInMillis'], showfliers=False)
axs[2,4].boxplot(keyed['advanced-node-task-client-single-worker']['100']['allDurationsInMillis'], showfliers=False)

axs[0,5].boxplot(keyed['advanced-node-task-client-double-worker']['1']['allDurationsInMillis'], showfliers=False)
axs[1,5].boxplot(keyed['advanced-node-task-client-double-worker']['10']['allDurationsInMillis'], showfliers=False)
axs[2,5].boxplot(keyed['advanced-node-task-client-double-worker']['100']['allDurationsInMillis'], showfliers=False)

plt.savefig('./all_boxplots.png')

# # ===== All in View =====

# # ===== 1st Subsection - 1 Concurrent across all 6 =====

# # ===== 2nd Subsection - 1 & 10 Concurrent across all 6 =====
# # - Java Class the same
# # - Progressively higher

# # ===== 3rd Subsection - 100 across all 6 =====
# # - Possible throttling because of max connections


# # ===== Comparing with possible latency effects =====
# keyed['basic-java-class']['1']['allDurationsInMillis']
# keyed['basic-node-task-client-single-worker']['1']['allDurationsInMillis']
# # have to compare against a java tomcat server



# # ===== Examine Node Task Client worker parallelism =====
# keyed['basic-node-task-client-single-worker']['100']['allDurationsInMillis']
# keyed['basic-node-task-client-double-worker']['100']['allDurationsInMillis']

# keyed['advanced-node-task-client-single-worker']['1']['allDurationsInMillis']
# keyed['advanced-node-task-client-single-worker']['10']['allDurationsInMillis']
# keyed['advanced-node-task-client-single-worker']['100']['allDurationsInMillis']
# keyed['advanced-node-task-client-double-worker']['1']['allDurationsInMillis']
# keyed['advanced-node-task-client-double-worker']['10']['allDurationsInMillis']
# keyed['advanced-node-task-client-double-worker']['100']['allDurationsInMillis']
# -> very prominent



# ===== Without rate limiting on the Tomcat server =====
# Suspicion: network latency / ping (even on localhost?)
# Built in Tomcat rate limit through the Semaphore Valve (limit 10 concurrent)



# End with: Any other tradeoff considerations that could be worth looking at? Drop me a note in the comments below!