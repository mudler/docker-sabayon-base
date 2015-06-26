BEGIN TRANSACTION;
CREATE TABLE IF NOT EXISTS baseinfo (
                    idpackage INTEGER PRIMARY KEY AUTOINCREMENT,
                    atom VARCHAR,
                    category VARCHAR,
                    name VARCHAR,
                    version VARCHAR,
                    versiontag VARCHAR,
                    revision INTEGER,
                    branch VARCHAR,
                    slot VARCHAR,
                    license VARCHAR,
                    etpapi INTEGER,
                    trigger INTEGER
                );
CREATE TABLE IF NOT EXISTS extrainfo (
                    idpackage INTEGER PRIMARY KEY,
                    description VARCHAR,
                    homepage VARCHAR,
                    download VARCHAR,
                    size VARCHAR,
                    chost VARCHAR,
                    cflags VARCHAR,
                    cxxflags VARCHAR,
                    digest VARCHAR,
                    datecreation VARCHAR,
                    FOREIGN KEY(idpackage)
                        REFERENCES baseinfo(idpackage) ON DELETE CASCADE
                );
CREATE TABLE IF NOT EXISTS content (
                    idpackage INTEGER,
                    file VARCHAR,
                    type VARCHAR,
                    FOREIGN KEY(idpackage)
                        REFERENCES baseinfo(idpackage) ON DELETE CASCADE
                );
CREATE TABLE IF NOT EXISTS contentsafety (
                    idpackage INTEGER,
                    file VARCHAR,
                    mtime FLOAT,
                    sha256 VARCHAR,
                    FOREIGN KEY(idpackage)
                        REFERENCES baseinfo(idpackage) ON DELETE CASCADE
                );
CREATE TABLE IF NOT EXISTS provide (
                    idpackage INTEGER,
                    atom VARCHAR,
                    is_default INTEGER DEFAULT 0,
                    FOREIGN KEY(idpackage)
                        REFERENCES baseinfo(idpackage) ON DELETE CASCADE
                );
CREATE TABLE IF NOT EXISTS dependencies (
                    idpackage INTEGER,
                    iddependency INTEGER,
                    type INTEGER,
                    FOREIGN KEY(idpackage)
                        REFERENCES baseinfo(idpackage) ON DELETE CASCADE
                );
CREATE TABLE IF NOT EXISTS dependenciesreference (
                    iddependency INTEGER PRIMARY KEY AUTOINCREMENT,
                    dependency VARCHAR
                );
CREATE TABLE IF NOT EXISTS conflicts (
                    idpackage INTEGER,
                    conflict VARCHAR,
                    FOREIGN KEY(idpackage)
                        REFERENCES baseinfo(idpackage) ON DELETE CASCADE
                );
CREATE TABLE IF NOT EXISTS mirrorlinks (
                    mirrorname VARCHAR,
                    mirrorlink VARCHAR
                );
CREATE TABLE IF NOT EXISTS sources (
                    idpackage INTEGER,
                    idsource INTEGER,
                    FOREIGN KEY(idpackage)
                        REFERENCES baseinfo(idpackage) ON DELETE CASCADE
                );
CREATE TABLE IF NOT EXISTS sourcesreference (
                    idsource INTEGER PRIMARY KEY AUTOINCREMENT,
                    source VARCHAR
                );
CREATE TABLE IF NOT EXISTS useflags (
                    idpackage INTEGER,
                    idflag INTEGER,
                    FOREIGN KEY(idpackage)
                        REFERENCES baseinfo(idpackage) ON DELETE CASCADE
                );
CREATE TABLE IF NOT EXISTS useflagsreference (
                    idflag INTEGER PRIMARY KEY AUTOINCREMENT,
                    flagname VARCHAR
                );
CREATE TABLE IF NOT EXISTS keywords (
                    idpackage INTEGER,
                    idkeyword INTEGER,
                    FOREIGN KEY(idpackage)
                        REFERENCES baseinfo(idpackage) ON DELETE CASCADE
                );
CREATE TABLE IF NOT EXISTS keywordsreference (
                    idkeyword INTEGER PRIMARY KEY AUTOINCREMENT,
                    keywordname VARCHAR
                );
CREATE TABLE IF NOT EXISTS configprotect (
                    idpackage INTEGER PRIMARY KEY,
                    idprotect INTEGER,
                    FOREIGN KEY(idpackage)
                        REFERENCES baseinfo(idpackage) ON DELETE CASCADE
                );
CREATE TABLE IF NOT EXISTS configprotectmask (
                    idpackage INTEGER PRIMARY KEY,
                    idprotect INTEGER,
                    FOREIGN KEY(idpackage)
                        REFERENCES baseinfo(idpackage) ON DELETE CASCADE
                );
CREATE TABLE IF NOT EXISTS configprotectreference (
                    idprotect INTEGER PRIMARY KEY AUTOINCREMENT,
                    protect VARCHAR
                );
CREATE TABLE IF NOT EXISTS systempackages (
                    idpackage INTEGER PRIMARY KEY,
                    FOREIGN KEY(idpackage)
                        REFERENCES baseinfo(idpackage) ON DELETE CASCADE
                );
CREATE TABLE IF NOT EXISTS injected (
                    idpackage INTEGER PRIMARY KEY,
                    FOREIGN KEY(idpackage)
                        REFERENCES baseinfo(idpackage) ON DELETE CASCADE
                );
CREATE TABLE IF NOT EXISTS installedtable (
                    idpackage INTEGER PRIMARY KEY,
                    repositoryname VARCHAR,
                    source INTEGER,
                    FOREIGN KEY(idpackage)
                        REFERENCES baseinfo(idpackage) ON DELETE CASCADE
                );
CREATE TABLE IF NOT EXISTS sizes (
                    idpackage INTEGER PRIMARY KEY,
                    size INTEGER,
                    FOREIGN KEY(idpackage)
                        REFERENCES baseinfo(idpackage) ON DELETE CASCADE
                );
CREATE TABLE IF NOT EXISTS counters (
                    counter INTEGER,
                    idpackage INTEGER,
                    branch VARCHAR,
                    PRIMARY KEY(idpackage,branch),
                    FOREIGN KEY(idpackage)
                        REFERENCES baseinfo(idpackage) ON DELETE CASCADE
                );
CREATE TABLE IF NOT EXISTS trashedcounters (
                    counter INTEGER
                );
CREATE TABLE IF NOT EXISTS needed_libs (
                    idpackage INTEGER,
                    lib_user_path VARCHAR,
                    lib_user_soname VARCHAR,
                    soname VARCHAR,
                    elfclass INTEGER,
                    rpath VARCHAR,
                    FOREIGN KEY(idpackage)
                        REFERENCES baseinfo(idpackage) ON DELETE CASCADE
                );
CREATE TABLE IF NOT EXISTS provided_libs (
                    idpackage INTEGER,
                    library VARCHAR,
                    path VARCHAR,
                    elfclass INTEGER,
                    FOREIGN KEY(idpackage)
                        REFERENCES baseinfo(idpackage) ON DELETE CASCADE
                );
CREATE TABLE IF NOT EXISTS treeupdates (
                    repository VARCHAR PRIMARY KEY,
                    digest VARCHAR
                );
CREATE TABLE IF NOT EXISTS treeupdatesactions (
                    idupdate INTEGER PRIMARY KEY AUTOINCREMENT,
                    repository VARCHAR,
                    command VARCHAR,
                    branch VARCHAR,
                    date VARCHAR
                );
CREATE TABLE IF NOT EXISTS licensedata (
                    licensename VARCHAR UNIQUE,
                    text BLOB,
                    compressed INTEGER
                );
CREATE TABLE IF NOT EXISTS licenses_accepted (
                    licensename VARCHAR UNIQUE
                );
CREATE TABLE IF NOT EXISTS triggers (
                    idpackage INTEGER PRIMARY KEY,
                    data BLOB,
                    FOREIGN KEY(idpackage)
                        REFERENCES baseinfo(idpackage) ON DELETE CASCADE
                );
CREATE TABLE IF NOT EXISTS entropy_misc_counters (
                    idtype INTEGER PRIMARY KEY,
                    counter INTEGER
                );
CREATE TABLE IF NOT EXISTS categoriesdescription (
                    category VARCHAR,
                    locale VARCHAR,
                    description VARCHAR
                );
CREATE TABLE IF NOT EXISTS packagesets (
                    setname VARCHAR,
                    dependency VARCHAR
                );
CREATE TABLE IF NOT EXISTS packagechangelogs (
                    category VARCHAR,
                    name VARCHAR,
                    changelog BLOB,
                    PRIMARY KEY (category, name)
                );
CREATE TABLE IF NOT EXISTS automergefiles (
                    idpackage INTEGER,
                    configfile VARCHAR,
                    md5 VARCHAR,
                    FOREIGN KEY(idpackage)
                        REFERENCES baseinfo(idpackage) ON DELETE CASCADE
                );
CREATE TABLE IF NOT EXISTS packagedesktopmime (
                    idpackage INTEGER,
                    name VARCHAR,
                    mimetype VARCHAR,
                    executable VARCHAR,
                    icon VARCHAR,
                    FOREIGN KEY(idpackage)
                        REFERENCES baseinfo(idpackage) ON DELETE CASCADE
                );
CREATE TABLE IF NOT EXISTS packagedownloads (
                    idpackage INTEGER,
                    download VARCHAR,
                    type VARCHAR,
                    size INTEGER,
                    disksize INTEGER,
                    md5 VARCHAR,
                    sha1 VARCHAR,
                    sha256 VARCHAR,
                    sha512 VARCHAR,
                    gpg BLOB,
                    FOREIGN KEY(idpackage)
                        REFERENCES baseinfo(idpackage) ON DELETE CASCADE
                );
CREATE TABLE IF NOT EXISTS provided_mime (
                    mimetype VARCHAR,
                    idpackage INTEGER,
                    FOREIGN KEY(idpackage)
                        REFERENCES baseinfo(idpackage) ON DELETE CASCADE
                );
CREATE TABLE IF NOT EXISTS packagesignatures (
                    idpackage INTEGER PRIMARY KEY,
                    sha1 VARCHAR,
                    sha256 VARCHAR,
                    sha512 VARCHAR,
                    gpg BLOB,
                    FOREIGN KEY(idpackage)
                        REFERENCES baseinfo(idpackage) ON DELETE CASCADE
                );
CREATE TABLE IF NOT EXISTS packagespmphases (
                    idpackage INTEGER PRIMARY KEY,
                    phases VARCHAR,
                    FOREIGN KEY(idpackage)
                        REFERENCES baseinfo(idpackage) ON DELETE CASCADE
                );
CREATE TABLE IF NOT EXISTS packagespmrepository (
                    idpackage INTEGER PRIMARY KEY,
                    repository VARCHAR,
                    FOREIGN KEY(idpackage)
                        REFERENCES baseinfo(idpackage) ON DELETE CASCADE
                );
CREATE TABLE IF NOT EXISTS entropy_branch_migration (
                    repository VARCHAR,
                    from_branch VARCHAR,
                    to_branch VARCHAR,
                    post_migration_md5sum VARCHAR,
                    post_upgrade_md5sum VARCHAR,
                    PRIMARY KEY (repository, from_branch, to_branch)
                );
CREATE TABLE IF NOT EXISTS preserved_libs (
                    library VARCHAR,
                    elfclass INTEGER,
                    path VARCHAR,
                    atom VARCHAR,
                    PRIMARY KEY (library, path, elfclass)
                );
CREATE TABLE IF NOT EXISTS xpakdata (
                    idpackage INTEGER PRIMARY KEY,
                    data BLOB
                );
CREATE TABLE IF NOT EXISTS settings (
                    setting_name VARCHAR,
                    setting_value VARCHAR,
                    PRIMARY KEY(setting_name)
                );
INSERT INTO "settings" VALUES('arch', 'amd64');
INSERT INTO "settings" VALUES('on_delete_cascade', '1');
INSERT INTO "settings" VALUES('_baseinfo_extrainfo_2010', '1');
INSERT INTO "settings" VALUES('schema_revision', '6');
COMMIT;
