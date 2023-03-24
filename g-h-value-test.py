import subprocess
import time
import matplotlib.pyplot as plt
import numpy as np

g_values = range(1, 21)
h_values = range(1, 21)
g_h_values = []

for g in g_values:
    for h in h_values:
        if g>=((h)/2):
            continue
        g_h_values.append((str(g), str(h))) 
            
start_time = time.time()
i=1
test_values = {} 
for g, h in g_h_values:
    print("Test", i, "of", len(g_h_values))
    print("Elapsed time:", time.time() - start_time)
    print("g:", g, "h:", h)
    i+=1 
    outputs = subprocess.run(["./ff", "-E", "-g", g, "-h", h, "-o", "domain-1.pddl", "-f", "problem-hard.pddl"], stdout=subprocess.PIPE, text=True).stdout.split("\n")
    reference_line = [line for line in outputs if line.startswith("time spent")]
    if reference_line:
        ref = outputs.index(reference_line[0])
        total_time= outputs[ref+6][14:19]
        steps_taken= outputs[ref-3][6:9]
        print(f"{steps_taken} step path found in {total_time} seconds \n")
        test_values.update({float(g)/float(h) : [steps_taken,total_time]})
    else:
        test_values = [g,h,0,0]

test_values = dict(sorted(test_values.items()))
ghratio = list(test_values.keys())
steps = [float(test_values[x][0]) for x in test_values]
times = [float(test_values[x][1]) for x in test_values]
print(ghratio)

# plot the graph for steps_taken vs. g and h
fig, ax = plt.subplots()
ax.plot(ghratio, steps)
ax.set_xlabel('g/h')
ax.set_ylabel('Steps taken')
plt.savefig('steps_taken.png')

# plot the graph for total_time vs. g and h
fig, ax = plt.subplots()
ax.plot(ghratio,times)
ax.set_xlabel('g/h')
ax.set_ylabel('Times')
plt.savefig('times.png')
