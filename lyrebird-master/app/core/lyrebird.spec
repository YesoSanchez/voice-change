Name:          lyrebird
Summary:       Simple and powerful voice changer for Linux, written in GTK 3.
URL:           https://github.com/charpointer/%{name}

Version:       1.1.0
Release:       3%{dist}
License:       MIT

Source0:       https://github.com/charpointer/%{name}/archive/refs/tags/v%{version}.tar.gz
BuildArch:     x86_64

BuildRequires: gettext

Requires:      python3 >= 3.7.0
Requires:      python3-toml
Requires:      python3-gobject
Requires:      pulseaudio
Requires:      sox

%description
Simple and powerful voice changer for Linux, written in GTK 3.

%prep
%setup -q -n %{name}-%{version}

%install
install -dm 0755 %{buildroot}/%{_bindir}
install -m 0755 %{name} %{buildroot}/%{_bindir}/
install -dm 0755 %{buildroot}/%{_datadir}/%{name}
cp -rf app app.py icon.png %{buildroot}/%{_datadir}/%{name}/
install -dm 0755 %{buildroot}/%{_datadir}/applications
BIN_PATH=%{_bindir} SHARE_PATH=%{_datadir}/%{name} envsubst < %{name}.desktop > %{buildroot}/%{_datadir}/applications/%{name}.desktop

%files
%defattr(-,root,root,-)
%{_bindir}/%{name}
%{_datadir}/%{name}
%{_datadir}/applications/%{name}.desktop
%license LICENSE
%doc README.md CHANGELOG.md

%changelog
* Sun Apr 04 2021 sT331h0rs3 <sT331h0rs3@gmail.com> - 1.1.0-3
- Initial RPM packaging for Fedora is done.

