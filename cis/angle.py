from matplotlib.colors import LogNorm
import matplotlib.pyplot as plt
import numpy as np
np.set_printoptions(threshold=np.inf)

font = {'family' : 'normal',
        'weight' : 'normal',
        'size'   : 30}

plt.rc('font', **font)

plt.figure(num=None, figsize=(13, 10), dpi=100, facecolor='w', edgecolor='k')

# normal distribution center at x=0 and y=5
x,y = np.loadtxt('ang.dat', comments={'#','@','&'}, usecols=(0,1), unpack=True)

plt.hist2d(x, y, bins=45, cmin=1, normed=True)
plt.colorbar()
plt.ylabel('Dipole-dipole angle')
plt.xlabel('Dihedral angle')

plt.savefig('angle.pdf',format='pdf')

plt.show()
