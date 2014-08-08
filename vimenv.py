"""
vimenv.py

Vim-specific environment helpers.  This module uses git and pathogen to manage
vim plugins.
"""
from collections import namedtuple
from os import path, makedirs, walk, chdir, getcwd
from urllib import urlretrieve
from subprocess import check_call


VimPlugin = namedtuple('VimPlugin', ['find_file', 'friendly', 'clone_url'])

plugins = [
        VimPlugin('NERD_tree.vim', 'NERDTree', 'https://github.com/scrooloose/nerdtree.git'),
        VimPlugin('unite.vim', 'Unite', 'https://github.com/Shougo/unite.vim.git'),
        VimPlugin('airline.vim', 'Airline', 'https://github.com/bling/vim-airline'),
        VimPlugin('fugitive.vim', 'Fugitive', 'git://github.com/tpope/vim-fugitive.git'),
        VimPlugin('vimproc.vim', 'vimproc', 'https://github.com/Shougo/vimproc.vim.git'),
        VimPlugin('molokai.vim', 'Molokai', 'https://github.com/tomasr/molokai.git'),
    ]

_dotvim = path.expanduser('~/.vim')
_autoload = path.join(_dotvim, 'autoload')
_bundle = path.join(_dotvim, 'bundle')


def ensure_pathogen():
    if path.isfile(path.join(_dotvim, 'autoload/pathogen.vim')):
        return

    print 'Pathogen not installed, getting it.'
    if not path.exists(_autoload):
        print 'making autoload dir'
        makedirs(_autoload)
    if not path.exists(_bundle):
        print 'making bundle dir'
        makedirs(_bundle)

    print 'downloading pathogen'
    urlretrieve('https://tpo.pe/pathogen.vim',
            path.join(_autoload, 'pathogen.vim'))


def install_plugins():
    ensure_pathogen()

    def find_vim_file(dv):
        for root, dirs, files in walk(_dotvim):
            for file in files:
                if file == vp.find_file:
                    return True
        return False

    origwd = getcwd()
    chdir(_bundle)
    ex = None

    for vp in plugins:
        if find_vim_file(vp.find_file):
            print 'found ' + vp.friendly
            continue

        print 'cloning ' + vp.friendly
        clonecmd = ['git', 'clone', vp.clone_url]
        try:
            check_call(clonecmd)
        except Exception as e:
            ex = e
            break

    chdir(origwd)
    if ex is not None:
        raise ex

