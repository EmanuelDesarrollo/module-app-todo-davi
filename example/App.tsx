import { useEvent } from 'expo';
import { AvatarView } from 'module-app-todo-davi';
import { ScrollView, Text, View } from 'react-native';

export default function App() {

  return (
    <ScrollView style={styles.container}>
      <Text style={styles.header}>Module API Example</Text>
      <Group name="AvatarView">
        <AvatarView name="Santiago Lopez" style={styles.avatar} />
        <AvatarView name="Ana García" style={styles.avatar} />
        <AvatarView name="Carlos" style={styles.avatar} />
      </Group>
    </ScrollView>
  );
}

function Group(props: { name: string; children: React.ReactNode }) {
  return (
    <View style={styles.group}>
      <Text style={styles.groupHeader}>{props.name}</Text>
      {props.children}
    </View>
  );
}

const styles = {
  header: {
    fontSize: 30,
    margin: 20,
    marginTop: 40,
  },
  groupHeader: {
    fontSize: 20,
    marginBottom: 20,
  },
  group: {
    margin: 20,
    backgroundColor: '#fff',
    borderRadius: 10,
    padding: 20,
  },
  container: {
    flex: 1,
    backgroundColor: '#eee',
  },
  view: {
    flex: 1,
    height: 200,
  },
  avatarRow: {
    flexDirection: 'row'
  },
  avatar: {
    width: 60,
    height: 60,
  },
};
