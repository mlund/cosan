#!/usr/bin/env python

import numpy as np
import re

class LoadGrace:
  """
  Simple module to load a Grace file (.agr) plot and extract
  legends, comments, and -- importantly -- data into numpy arrays.
  """
  
  def __init__(self, filename):
    self._sets = []
    self._legends = []
    self._comments = []

    f = open(filename, 'r')
    for line in f:
      if re.compile('@    s(.*) legend').search(line):
        self._legends.append( line.split('"')[1] )

      if re.compile('@    s(.*) comment').search(line):
        self._comments.append( line.split('"')[1] )

      if '@target' in line:
        tmp = []
        next(f)
        for row in f:
          if row!='&\n':
            tmp.append( np.fromstring( row, sep=' ' ) )
          else:
            self._sets.append( np.array(tmp) )
            break
    f.close()

  def sets(self): return self._sets
  def legends(self): return self._legends
  def comments(self): return self._comments
  def __len__(self): return len(self._sets)

