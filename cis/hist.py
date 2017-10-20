from matplotlib.colors import LogNorm
import matplotlib.pyplot as plt
import numpy as np
np.set_printoptions(threshold=np.inf)

font = {'family' : 'normal',
        'weight' : 'normal',
        'size'   : 30}
plt.rc('font', **font)

plt.figure(num=None, figsize=(13, 10), dpi=100, facecolor='w', edgecolor='k')

bonds = np.loadtxt('bonds.dat', comments={'#','@','&'}, unpack=True)
#print len(bonds)
N=10
ind= np.arange(N)
plt.hist(bonds, bins=ind, rwidth=1, normed=True)
plt.xticks(ind+0.5,('0','1','2','3','4','5','6','7','8'))
plt.xlabel('Number of bonds per frame')
plt.ylabel('Probability of occuring')
plt.savefig('histogram.png',format='png')


plt.show()


