#!/bin/bash
ROOT_DIR="$(realpath $(dirname ${BASH_SOURCE[0]}))/../"
cd $ROOT_DIR

mkdir -p $ROOT_DIR/logs/
exec 1>$ROOT_DIR/logs/last_script_output 2>$ROOT_DIR/logs/last_script_errors

# Load environment variables from .env file
source ".env"

# Copy KAS to tmp
mkdir -p $ROOT_DIR/$TMP_DIR
rm -rf $ROOT_DIR/$TMP_DIR/$SRC_KAS_PATH
cp -r $ROOT_DIR/$SRC_ROOT/$SRC_KAS_PATH $TMP_DIR

# Goto TMP Dir
cd $ROOT_DIR/$TMP_DIR/$SRC_KAS_PATH

# Cleanup
$ROOT_DIR/util/cleanup-pycache.bash
rm -rf examples logs/* .env.dev .env.local README.md

# Copy prod env
mv .env.prod .env

# Make Export
rm -rf $ROOT_DIR/$TMP_DIR/tmp_export/
mkdir -p $ROOT_DIR/$TMP_DIR/tmp_export/$PROD_KAS_PATH
mv ./* ./.* $ROOT_DIR/$TMP_DIR/tmp_export/$PROD_KAS_PATH

# Archive
cd $ROOT_DIR/$TMP_DIR/tmp_export/
mkdir -p $ROOT_DIR/$EXPORT_ROOT/
rm $ROOT_DIR/$EXPORT_ROOT/$EXPORT_NAME $ROOT_DIR/$EXPORT_ROOT/$EXPORT_DEPLOY_SCRIPT
zip -r $ROOT_DIR/$EXPORT_ROOT/$EXPORT_NAME $PROD_KAS_PATH
cp $ROOT_DIR/$EXPORT_DEPLOY_SCRIPT $ROOT_DIR/$EXPORT_ROOT

# Cleanup
cd $ROOT_DIR
rm -rf $ROOT_DIR/$TMP_DIR/tmp_export/
rm -rf $ROOT_DIR/$TMP_DIR/$SRC_KAS_PATH/

# exec >/dev/stdout 2>/dev/stderr

# Bye
echo Done