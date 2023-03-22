import subprocess
import time
import matplotlib.pyplot as plt

g_values = range(1, 11)
h_values = range(1, 11)
g_h_values = []

for g in g_values:
    for h in h_values:
        if g>=((3*h)/4):
            continue
        g_h_values.append((str(g), str(h))) 
            
start_time = time.time()
i=1

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
        print(f"{steps_taken} step path found in {total_time} seconds")
        test_values = [g,h,steps_taken,total_time]
    else:
        test_values = [g,h,"-","-"]

gs = [x[0] for x in test_values]
hs = [x[1] for x in test_values]
steps = [x[2] for x in test_values]
times = [x[3] for x in test_values]

# plot the graph for steps_taken vs. g and h
fig, ax = plt.subplots()
ax.scatter(gs, hs, c=steps)
ax.set_xlabel('g')
ax.set_ylabel('h')
ax.set_title('Steps taken')
plt.show()

# plot the graph for total_time vs. g and h
fig, ax = plt.subplots()
ax.scatter(gs, hs, c=times)
ax.set_xlabel('g')
ax.set_ylabel('h')
ax.set_title('Total time')
plt.show()
    