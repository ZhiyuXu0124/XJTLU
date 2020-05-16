import numpy as np
import matplotlib.pyplot as plt

fig = plt.figure()
ax = fig.add_subplot(1, 1, 1)

# Major ticks every 10, minor ticks every 5 for x axis
x_major_ticks = np.arange(0, 101, 10)
x_minor_ticks = np.arange(0, 101, 5)

# Major ticks every 0.1, minor ticks every 0.1 for y axis
y_major_ticks = np.arange(0, 1.1, 0.2)
y_minor_ticks = np.arange(0, 1.1, 0.1)

ax.set_xticks(x_major_ticks)
ax.set_xticks(x_minor_ticks, minor=True)
ax.set_yticks(y_major_ticks)
ax.set_yticks(y_minor_ticks, minor=True)

# Or if you want different settings for the grids:
ax.grid(which='minor', alpha=0.2)
ax.grid(which='major', alpha=0.5)

# calculate and plot analytical results
x1 = np.arange(1, 100)
a = x1/100
p0 = 1/(1+2*a+((((2*a)**2)/2)*1)/(1-a))
pm = (((2*a)**2)/(2*(1-a)))*p0
y1 = ((a/(x1*(1-a)))*pm)+1/50
plt.plot(x1, y1, 'b-', label="Analysis", linewidth=1)

# load and plot simulation results
x2, y2 = np.loadtxt('mm2.out', delimiter='\t', unpack=True)
plt.plot(x2, y2, 'rx', label="Simulation")

# add labels, legend, and title
plt.xlabel(r'$\lambda$ [pkts/s]')
plt.ylabel(r'$E[T]$ [s]')
plt.legend()
plt.title(r'M/M/2 ($\mu=50$ [pkts/s])')

plt.savefig('mm2.pdf')
plt.show()
