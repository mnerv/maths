# %% Imports
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
from scipy import signal
from matplotlib.ticker import EngFormatter

# %% Analytics
# Data for plotting
fs = 10.0
Ts = 1/fs
f = 5.0
t = np.arange(0.0, 2.0, Ts)
s = 1 + np.sin(2 * np.pi * f * t * Ts )

fig, ax = plt.subplots()
ax.plot(t, s)
# ax.stem(t, s)
ax.set(xlabel='time (s)', ylabel='voltage (mV)', title='Sinewave')
ax.grid(linewidth=1, color='lightgray', alpha=0.5)
ax.grid(which='minor', linestyle=':', linewidth=1, color='lightgray', alpha=0.25)

# plt.savefig("test.png", dpi=512)
plt.show()

# %%
