bashmaster(){
    ACTION="NONE"
    b='\033[1;5;255m'
    n='\033[0;5;255m'
    alias git=`git --git-dir=$BASH_DIR/.git --work-tree=$BASH_DIR`
    for i in "$@"; do
        case $i in
            get=*)
                FILENAME="${i#*=}"
                ACTION="get"
                shift # past argument=value
            ;;
            patch=*)
                FILENAME="${i#*=}"
                ACTION="patch"
                shift
            ;;
            from=*)
                BRANCH_NAME="${i#*=}"
                shift
            ;;
            list)
                git branch
                shift
            ;;
            home)
                name=`uname -n`
                git checkout $name
                unalias git
                source $BASH_DIR/dotfiles/.bash_run
                cd - > /dev/null
            ;;
            master)
                git checkout master
                unalias git
                source $BASH_DIR/dotfiles/.bash_run
                cd - > /dev/null
            ;;
            -h|--help*)
                echo -e "usage:"
                echo -e "   to$b GET$n file from branch:"
                echo -e "       bashmaster get=<filename> from=<branch>"
                echo -e "   to$b PATCH$n file from branch"
                echo -e "       bashmaster patch=<filename> from=<branch>"
                echo -e "   to$b LIST$n available branches"
                echo -e "       bashmaster list"
                echo -e "   to checkout your$b HOME$n branch"
                echo -e "       bashmaster home"
                echo -e "   to checkout the$b MASTER$n branch"
                echo -e "       bashmaster master"

                shift
            ;;
         esac
    done
    case ${ACTION} in
        get)
            alias git=`git --git-dir=$BASH_DIR/.git --work-tree=$BASH_DIR`
            `git checkout ${BRANCH_NAME} ${FILENAME}`
            unalias git
        ;;
        patch)
            alias git=`git --git-dir=$BASH_DIR/.git --work-tree=$BASH_DIR`
            `git checkout --patch ${BRANCH_NAME} ${FILENAME}`
            unalias git
        ;;
    esac
    unalias git
}
