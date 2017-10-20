from matplotlib.colors import LogNorm
import matplotlib.pyplot as plt
import numpy as np

# normal distribution center at x=0 and y=5
x,y = np.loadtxt('ang.dat', comments={'#','@','&'}, usecols=(0,1), unpack=True)

plt.hist2d(x, y, bins=45, cmin=1, normed=False)
plt.colorbar()
plt.ylabel('Dipole-dipole angle')
plt.xlabel('Dihedral angle')
#plt.grid(True)
plt.show()
