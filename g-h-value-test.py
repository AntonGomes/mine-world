import subprocess

g_values = [str(g) for g in range(1, 11)]
h_values = [str(h) for h in range(1, 11)]
g_h_values = [(1,10), (1,9), (1,8), (1,7)]
g_h_values = zip(g_values, h_values)

for g, h in g_h_values:
    outputs = subprocess.run(["./ff", "-E", "-g", g, "-h", h, "-o", "domain-1.pddl", "-f", "problem-hard.pddl"], stdout=subprocess.PIPE, text=True).stdout.split("\n")
    reference_line = [line for line in outputs if line.startswith("time spent")]
    if reference_line:
        ref = outputs.index(reference_line[0])
        total_time= outputs[ref+6][14:19]
        steps_taken= outputs[ref-3][6:9]
        test_values = [g,h,steps_taken,total_time]
    else:
        test_values = [g,h,"-","-"]