# Free My TV — versão personalizada

Este fork mantém as personalizações Android TV desenvolvidas para Wellington, com base no projeto MIT [simbasjungles/free-my-tv](https://github.com/simbasjungles/free-my-tv), commit `fa471834534b66b2323f98e79ada424306aadef4`.

## O que foi alterado

- **Dunas**, padrão: prateleira inferior original e fundos de dunas.
- **Minimalista**: aplicativos circulares em coluna lateral; relógio e clima à direita.
- **Cinema**: relógio menor no alto e cartões maiores com os nomes dos aplicativos.
- Cada estilo tem seu próprio par de fundos de dia/noite. As seis imagens estão em `app/assets/wallpaper*.png` e foram criadas com ImageGen.
- A aparência **Automático** usa o nascer e o pôr do sol da cidade configurada, alternando imagem, cores e vidro. Sem dados solares, o comportamento original usa 06:00 e 18:00.
- As imagens pessoais são desenhadas na resolução da interface, sem a redução para 480 × 270 nem o desfoque adicional. A interface desta TCL usa 1280 × 720; outras TVs podem usar até 1920 × 1080.
- O perfil de compilação personalizado mantém a proteção de tela original com `screensaver=false`.

O seletor está em **Free My TV → Ajustes do Início → Estilo do início**. OK ou as setas laterais alternam os estilos. Voltar aos ajustes anteriores/tela inicial aplica a escolha. A opção **Tema** (Automático/Claro/Escuro) controla a aparência de dia/noite separadamente.

No Minimalista, cima/baixo navegam nos aplicativos e direita abre entradas/previsão. Para alterar a ordem, use **Prateleira** nos ajustes. Cinema e Dunas mantêm a navegação horizontal. Os aplicativos, sua ordem e as demais preferências continuam no armazenamento do aplicativo; atualizar com a mesma assinatura as preserva.

Estas mudanças são para o aplicativo Android TV; os aplicativos webOS e Tizen permanecem como no projeto original.

## Compilar e atualizar

Os requisitos de JDK, SDK Android e ADB continuam no [README original](README.md). No Windows, execute os scripts pelo Git Bash.

```bash
./build-personal.sh
```

Na primeira execução, o script cria `config.properties` a partir de `config.personal.example.properties`. Antes de instalar, ajuste a cidade, latitude e longitude nesse arquivo local. As configurações já salvas na TV têm prioridade. Mantenha **screensaver=false** para preservar as paisagens originais.

Se já existe `config.properties`, ele não é sobrescrito. Confirme `screensaver=false` antes de compilar. Não use `--generic` para reproduzir esse perfil, pois esse modo ignora `config.properties`.

O APK fica em `FreeMyTV.apk`. Instale na mesma TV autorizada com:

```bash
adb connect <IP_DA_TV>:5555
adb install -r FreeMyTV.apk
```

**Guarde a chave `freemytv.keystore` em um backup privado.** Ela foi criada localmente e é necessária para atualizar a versão personalizada já instalada. Não está neste GitHub. Sem ela, uma nova compilação terá outra assinatura e exigirá voltar ao modo Original, desinstalar a versão anterior e configurar novamente. Nunca envie essa chave ao repositório.

`config.properties`, senhas, chaves de API, chaves de assinatura, APKs e arquivos temporários ficam fora do Git. A localização/IP específicos da TV também não fazem parte desta documentação pública.

## Receber melhorias do projeto original

Mantenha as personalizações neste fork e integre as atualizações antes de compilar:

```bash
git fetch upstream
git merge upstream/main
# Resolver conflitos preservando os estilos, os fundos e a opção screensaver=false.
tools/check.sh
./build-personal.sh
```

Cadastre `upstream` como `https://github.com/simbasjungles/free-my-tv.git` caso ainda não exista. Não substitua esta instalação por um APK oficial: ele tem outra assinatura e não inclui os estilos personalizados. As atualizações personalizadas são compiladas e instaladas com a chave local.

## Validação

As personalizações foram compiladas e os APKs tiveram a assinatura verificada. Os três estilos e os fundos claro/escuro foram conferidos na TCL com Android 9, incluindo o painel de entradas/previsão e a proteção de tela original. O script `tools/check.sh` reúne as verificações do projeto original.

## Arquivos principais

- `HomeView.java`: layouts, formatos dos aplicativos e navegação.
- `SettingsActivity.java` e `Prefs.java`: seletor e persistência do estilo.
- `Backdrop.java`: fundo nítido e combinação dos pares diurno/noturno.
- `Photos.java`: escolha e cache dos fundos por estilo.
- `app/assets/wallpaper*.png`: imagens incluídas no aplicativo.

O código original conserva sua licença MIT e créditos. Este fork não altera o repositório do autor original.
