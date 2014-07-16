#!/usr/bin/env python
"""
Install the various environment settings contained in this repository.
Currently supports only apt-get based Linux distributions (e.g. Ubuntu, its
forks like Mint, Debian...).
"""
import collections
import os
import platform
import shutil
import subprocess
import sys

import vimenv


dotfiles = [
        ('~/.bashrc', 'bashrc'),
        ('~/.bash_aliases', 'bash_aliases'),
        ('~/.profile', 'profile'),
        ('~/.vimrc', 'vimrc'),
        ('~/.tmux.conf', 'tmux.conf'),
        ]


software = [
        ('git', ['git']),
        ('ag', ['silversearcher-ag']),
        ('vim', ['vim', 'vim-gnome']),
        ('tmux', ['tmux']),
    ]


class _status:
    FAIL = ('\033[91m', '[FAIL] ')
    DONE = ('\033[92m', '[DONE] ')
    INFO = ('\033[94m', '[INFO] ')
    _RESET = '\033[0m'


def _print(stat, string):
    color, text = stat
    print color + text + string + _status._RESET


def install_vim_plugins():
    try:
        _print(_status.INFO, 'Installing vim plugins')
        vimenv.install_plugins()
    except Exception as e:
        _print(_status.FAIL, 'Failed during vim plugin install: ' + e)


def install_dotfiles():
    """
    Copy repository versions of dotfiles into local configuration.  Do it using
    symlinks if possible.  If a dotfile exists at the destination, move it to
    <destination>.bak (unless it's a link).
    """
    _print(_status.INFO, 'Installing dotfiles')
    fn = None
    try:
        fn = os.symlink
    except AttributeError:
        fn = shutil.copy2

    try:
        for dst, src in dotfiles:
            dstfull = os.path.expanduser(dst)
            srcfull = os.path.join(os.path.dirname(os.path.realpath(__file__)),
                    src)

            if os.path.exists(dstfull):
                print 'backing up ' + dstfull
                os.rename(dstfull, dstfull + '.bak')
            print 'installing ' + dstfull
            fn(srcfull, dstfull)
    except OSError as e:
        _print(_status.FAIL, 'Error while installing {}:\n  {}'.format(dst, e))
        raise


def install_software():
    """
    Check software tuples for executable names in path.  For ones that don't
    exist, install the packages specified for that program.
    """
    _print(_status.INFO, 'Installing software')
    def _program_in_path(program):
        return subprocess.call(['which', program],
                stdout=open(os.devnull,'wb')) == 0

    apt_install = ['apt-get', 'install', '-y']
    for program, packages in software:
        if not _program_in_path(program):
            command = apt_install[:]
            command.extend(packages)
            print ' '.join(command)
            try:
                subprocess.check_call(command)
            except subprocess.CalledProcessError as e:
                _print(_status.FAIL, 'Error installing packages {}, see above.'
                        .format(packages))
                raise
        else:
            print '{} is installed.'.format(program)


commands = collections.OrderedDict([
        ('software', install_software),
        ('dotfiles', install_dotfiles),
        ('vim_plugins', install_vim_plugins),
    ])


def usage():
    print 'usage: {} [COMMAND...]'.format(sys.argv[0])
    print '  install environment customizations to a machine.'
    print
    print '  COMMAND is one or more of:'
    for cmd in commands.keys():
        print '    ' + cmd
    print
    print '  If no command is specified, all are run.'


if __name__ == '__main__':
    cmd_fns = []
    cmd_names = sys.argv[1:] if len(sys.argv) >= 2 else commands.keys()

    try:
        for cmd_name in cmd_names:
            cmd_fns.append(commands[cmd_name])
    except KeyError as e:
        print 'Invalid command: {}'.format(e)
        usage()
        exit(1)

    try:
        for cmd_fn in cmd_fns:
            cmd_fn()
    except:
        _print(_status.FAIL, 'Aborting.')
        exit(2)

    _print(_status.DONE, 'Finished.')
